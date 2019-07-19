require 'rails_helper'

RSpec.describe "Sign up", type: :request do
  it "supports signing up with basic info" do
    park = create(:park)
    variables = OpenStruct.new(
      email: 'someemail@example.com',
      password: 'password',
      password_confirmation: 'password',
      phone_number: '(123) 456-7890',
      accepts_sms: true,
      park_id: park.id
    )

    result = graphql(query: sign_up_mutation, variables: variables).data.sign_up

    user = result.user
    expect(user.email).to eq(variables.email)
    expect(user.phone_number).to eq(variables.phone_number)
    expect(user.accepts_sms).to eq(variables.accepts_sms)
    expect(user.type).to eq(Types::UserEnum::MEMBER.to_s)
    expect(user.park.id).to eq(park.id.to_s)
    expect(result.auth.authentication_token).not_to be_nil
  end

  it "returns errors" do
    variables = OpenStruct.new(
      email: 'someemail@example.com',
      password: 'password',
      password_confirmation: 'a different password',
      phone_number: 'not a phone number'
    )
    create(:member, email: variables.email)

    result = graphql(query: sign_up_mutation, variables: variables)

    errors = result.data.sign_up.errors
    expect(errors.first).to have_attributes(path: 'park', message: 'must exist')
    expect(errors.second).to have_attributes(path: 'email', message: 'An account already exists for this email')
    expect(errors.third).to have_attributes(path: 'phoneNumber', message: 'Phone number must be 10 digits')
    expect(errors.fourth).to have_attributes(path: 'password', message: "Passwords don't match")
  end

  def sign_up_mutation
    <<~GQL
      mutation SignUp($email: String!, $password: String!, $passwordConfirmation: String!, $phoneNumber: String, $acceptsSms: Boolean, $parkId: ID) {
        signUp(email: $email, password: $password, passwordConfirmation: $passwordConfirmation, phoneNumber: $phoneNumber, acceptsSms: $acceptsSms, parkId: $parkId) {
          user {
            id
            email
            phoneNumber
            acceptsSms
            profilePicture {
              url
              name
            }
            type
            park {
              id
            }
          }
          auth {
            authenticationToken
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