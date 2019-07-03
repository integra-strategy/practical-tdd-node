require 'rails_helper'

RSpec.describe "Sign in", type: :request do
  it "returns an authentication token and the user" do
    variables = OpenStruct.new(email: 'someemail@example.com', password: 'password')
    user = create(:member, email: variables.email, password: variables.password)

    result = graphql(query: sign_in_mutation, variables: variables).data.sign_in

    expect(result.auth.authentication_token).to be_truthy
    expect(result.user.id).to eq(user.id.to_s)
  end
end