require 'rails_helper'

RSpec.describe "Sign up", type: :request do
  it "supports signing up with basic info" do
    variables = OpenStruct.new(
      email: 'someemail@example.com',
      password: 'password',
      phone_number: '(123) 456-7890',
      accepts_sms: true
    )

    result = graphql(query: sign_up_mutation, variables: variables)

    user = result.data.sign_up.user
    expect(user.email).to eq(variables.email)
    expect(user.phone_number).to eq(variables.phone_number)
    expect(user.accepts_sms).to eq(variables.accepts_sms)
  end

  it "returns errors" do
    variables = OpenStruct.new(
      email: 'someemail@example.com',
      password: 'password',
      phone_number: 'not a phone number'
      )
    create(:user, email: variables.email)

    result = graphql(query: sign_up_mutation, variables: variables)

    errors = result.data.sign_up.errors
    expect(errors.first).to have_attributes(path: 'email', message: 'An account already exists for this email')
    expect(errors.second).to have_attributes(path: 'phoneNumber', message: 'Phone number must be 10 digits')
  end

  def sign_up_mutation
    <<~GQL
      mutation SignUp($email: String!, $password: String!, $phoneNumber: String, $acceptsSms: Boolean) {
        signUp(email: $email, password: $password, phoneNumber: $phoneNumber, acceptsSms: $acceptsSms) {
          user {
            email
            phoneNumber
            acceptsSms
            profilePicture
          }
          errors {
            path
            message
          }
        }
      }
    GQL
  end
end