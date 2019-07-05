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

  def user_detail(variables:, user:)
    graphql(query: user_detail_query, variables: variables, user: user).data.user_detail
  end
end
