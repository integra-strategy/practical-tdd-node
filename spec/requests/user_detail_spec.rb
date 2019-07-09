require 'rails_helper'

RSpec.describe "User detail", type: :request do
  it "returns details about the user" do
    plan = create(:stripe_plan)
    user = create(:member, first_name: "John", package: plan.id)
    dog = create(:dog, user: user)
    variables = OpenStruct.new(id: user.id)

    result = user_detail(variables: variables, user: user)

    expect(result.first_name).to eq(user.first_name)
    expect(result.dogs.first.id.to_i).to eq(dog.id)
    expect(result.package.id).to eq(plan.id)
  end

  it "returns whether or not a user's subscription is active" do
    stub_stripe_with_invalid_subscription
    plan = create(:stripe_plan)
    member = create(:member, package: plan.id)
    dog = create(:dog, user: member)
    variables = OpenStruct.new(id: member.id)

    result = user_detail(variables: variables, user: member)

    expect(result.subscription_active).to eq(false)
  end

  def user_detail(variables:, user:)
    graphql(query: user_detail_query, variables: variables, user: user).data.user_detail
  end

  # I couldn't find an easy way to simulate an inactive subscription with the Stripe Ruby mock,
  # so we're just stubbing out the the call to Stripe to return an inactive subscription.
  def stub_stripe_with_invalid_subscription
    allow(Stripe::Customer).to receive(:retrieve) do
      OpenStruct.new(subscriptions: [OpenStruct.new(status: 'inactive')] )
    end
  end
end
