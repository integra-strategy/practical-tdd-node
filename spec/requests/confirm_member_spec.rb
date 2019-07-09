require 'rails_helper'

RSpec.describe "Confirming a member", type: :request do
  it "confirms the member" do
    context = create_context

    result = confirm_member(context.member, context.employee).user

    expect(result.confirmed).to eq(true)
  end

  it "starts the member's subscription" do
    allow(Stripe::Subscription).to receive(:create).and_call_original
    context = create_context
    member = context.member

    result = confirm_member(member, context.employee).user
    member.reload

    expect(member.stripe_id).to eq(Stripe::Customer.list.first.id)
    expect(Stripe::Subscription.list.first.plan.id).to eq(context.plan.id)
    expect(Stripe::Subscription).not_to have_received(:create).with(hash_including(cancel_at_period_end: true))
  end

  # To keep all of the logic the same, we're handling daily and month-to-month subscriptions
  # just like monthly and yearly subscriptions, but just setting them to cancel automatically
  # at the end of their period.
  it "sets 1 time charge subscriptions to cancel at the end of the current period" do
    # The Stripe Ruby mock doesn't support the cancel_at_period_end parameter yet.
    allow(Stripe::Subscription).to receive(:create)
    context = create_context(one_time_charge: true)
    member = context.member

    result = confirm_member(member, context.employee).user
    member.reload

    expect(Stripe::Subscription).to have_received(:create).with(hash_including(cancel_at_period_end: true))
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

  def create_context(card_number: nil, one_time_charge: build(:stripe_plan).one_time_charge)
    plan = create(:stripe_plan, one_time_charge: one_time_charge)
    token = create_card(card_number)
    member = create(:member, :with_name, unconfirmed: true, package: plan.id, stripe_card_token: token.id)
    employee = create(:employee)
    OpenStruct.new(member: member, employee: employee, plan: plan)
  end

  def create_card(card_number)
    return create(:stripe_card_token, number: card_number) if card_number
    create(:stripe_card_token)
  end
end