require 'rails_helper'

RSpec.describe "Confirming a member", type: :request do
  it "confirms the member" do
    context = create_context

    result = confirm_member(context.member, context.employee).user

    expect(result.confirmed).to eq(true)
  end

  it "starts the member's subscription" do
    context = create_context
    member = context.member

    result = confirm_member(member, context.employee).user
    member.reload

    expect(member.stripe_id).to eq(Stripe::Customer.list.first.id)
    expect(Stripe::Subscription.list.first.plan.id).to eq(context.plan.id)
  end

  it "handles failed subscriptions" do
    StripeMock.prepare_card_error(:card_declined, :create_subscription)
    context = create_context(card_number: '4000000000000341')

    result = confirm_member(context.member, context.employee).errors.first

    expect(result.path).to eq('card')
    expect(result.message).to eq('The card was declined')
  end

  def confirm_member(member, employee)
    mutation = <<~GQL
      mutation ConfirmMember($input: ConfirmMember!) {
        confirmMember(input: $input) {
          user {
            confirmed
          }
          errors {
            path
            message
          }
        }
      }
    GQL
    variables = OpenStruct.new(input: { id: member.id })
    graphql(query: mutation, variables: variables, user: employee).data.confirm_member
  end

  def create_context(card_number: nil)
    plan = create(:stripe_plan)
    token = create_card(card_number)
    member = create(:member, :with_name, unconfirmed: true, package: plan.id, token: token.id)
    employee = create(:employee)
    OpenStruct.new(member: member, employee: employee, plan: plan)
  end

  def create_card(card_number)
    return create(:stripe_token, number: card_number) if card_number
    create(:stripe_token)
  end
end