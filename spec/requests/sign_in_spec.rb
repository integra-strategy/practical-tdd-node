require 'rails_helper'

RSpec.describe "Sign in", type: :request do
  it "returns an authentication token and the user" do
    variables = OpenStruct.new(email: 'someemail@example.com', password: 'password')
    user = create(:member, email: variables.email, password: variables.password)

    result = sign_in(variables: variables)

    expect(result.auth.authentication_token).to be_truthy
    expect(result.user.id).to eq(user.id.to_s)
  end

  it "doesn't allow deactived users to sign in" do
    password = 'password'
    user = create(:member, password: password, deactivated: true)
    variables = OpenStruct.new(email: user.email, password: password)

    result = sign_in(variables: variables, throw_errors: false)

    expect(result).to be_nil
  end

  def sign_in(variables: variables, throw_errors: true)
    graphql(query: sign_in_mutation, variables: variables, throw_errors: throw_errors).data.sign_in
  end
end