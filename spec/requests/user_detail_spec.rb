require 'rails_helper'

RSpec.describe "User detail", type: :request do
  it "returns details about the user" do
    variables = OpenStruct.new(email: 'someemail@example.com', password: 'password')
    user = create(:user, first_name: "John", email: variables.email, password: variables.password)
    authentication_token = graphql(query: sign_in_mutation, variables: variables).data.sign_in.authentication_token

    result = graphql(query: user_detail_query, authentication_token: authentication_token)

    expect(result.data.user_detail.first_name).to eq(user.first_name)
  end
end
