require 'rails_helper'

RSpec.describe "Sign in", type: :request do
  it "returns an authentication token" do
    variables = OpenStruct.new(email: 'someemail@example.com', password: 'password')
    user = create(:user, email: variables.email, password: variables.password)

    result = graphql(query: sign_in_mutation, variables: variables)

    expect(result.data.sign_in.authentication_token).to be_truthy
  end
end