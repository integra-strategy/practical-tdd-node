require 'rails_helper'

RSpec.describe "Sign in", type: :request do
  it "returns an authentication token and the user" do
    variables = OpenStruct.new(email: 'someemail@example.com', password: 'password')
    user = create(:user, email: variables.email, password: variables.password)

    result = graphql(query: sign_in_mutation, variables: variables).data.sign_in

    expect(result.auth.authentication_token).to be_truthy
    expect(result.user.id).to eq(user.id.to_s)
  end

  it "doesn't allow members to sign in until their account has been confirmed" do
    pending("We have to wait to implement this functionality until FET-101 is implemented. Otherwise, we won't have a way to sign members in.")
    variables = OpenStruct.new(email: 'someemail@example.com', password: 'password')
    user = build(:user, email: variables.email, password: variables.password, confirmed_at: nil)
    user.skip_confirmation_notification!
    user.save

    result = graphql(query: sign_in_mutation, variables: variables, throw_errors: false)

    expect(result.errors.first).to have_attributes(message: "User account not confirmed. The user's account must be confirmed before signing in.")
  end
end