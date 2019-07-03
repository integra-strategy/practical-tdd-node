require 'rails_helper'

RSpec.describe "Confirming a member", type: :request do
  it "confirms the member" do
    member = create(:member, unconfirmed: true)
    employee = create(:employee)

    result = confirm_member(member, employee).user

    expect(result.confirmed).to eq(true)
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