require 'rails_helper'

RSpec.describe "Member detail", type: :request do
  it "returns details about the member" do
    email = 'someemail@example.com'
    password = 'password'
    member = create(:member, first_name: "John", email: email, password: password)
    authentication_token = graphql(query: sign_in_mutation(email: email, password: password), operation_name: 'SignIn').data.sign_in.authentication_token

    result = graphql(query: member_detail_query, authentication_token: authentication_token, operation_name: 'MemberDetail')

    expect(result.errors).to be_nil
    expect(result.data.member_detail.first_name).to eq(member.first_name)
  end

  def member_detail_query
    <<~GQL
      query MemberDetail {
        memberDetail {
          firstName
        }
      }
    GQL
  end
end
