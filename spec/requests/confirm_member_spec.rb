require 'rails_helper'

RSpec.describe "Confirming a member", type: :request do
  it "confirms the member" do
    plan = create(:stripe_plan)
    token = create(:stripe_token)
    member = create(:member, unconfirmed: true, package: plan.id, token: token.id)
    employee = create(:employee)

    result = confirm_member(member, employee).user

    expect(result.confirmed).to eq(true)
  end

  it "starts the member's subscription" do
    plan = create(:stripe_plan)
    token = create(:stripe_token)
    member = create(:member, :with_name, unconfirmed: true, package: plan.id, token: token.id)
    employee = create(:employee)

    result = confirm_member(member, employee).user
    member.reload

    expect(member.stripe_id).to eq(Stripe::Customer.list.first.id)
    expect(Stripe::Subscription.list.first.plan.id).to eq(plan.id)
  end

  def confirm_member(member, employee)
    mutation = <<~GQL
      mutation ConfirmMember($input: ConfirmMember!) {
        confirmMember(input: $input) {
          user {
            confirmed
          }
        }
      }
    GQL
    variables = OpenStruct.new(input: { id: member.id })
    graphql(query: mutation, variables: variables, user: employee).data.confirm_member
  end
end