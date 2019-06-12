require 'rails_helper'

RSpec.describe "Sign up", type: :request do
  it "supports signing up with basic info" do
    variables = OpenStruct.new(
      email: 'someemail@example.com',
      password: 'password',
      first_name: 'John',
      last_name: 'Doe',
      authorized_users: ['Jane Doe'],
      phone_number: '(123) 456-7890',
      accepts_sms: true,
      profile_picture: 'https://some.url.com'
    )

    result = graphql(query: sign_up_mutation, variables: variables)

    user = result.data.sign_up.user
    expect(user.email).to eq(variables.email)
    expect(user.first_name).to eq(variables.first_name)
    expect(user.last_name).to eq(variables.last_name)
    expect(user.authorized_users).to eq(variables.authorized_users)
    expect(user.phone_number).to eq(variables.phone_number)
    expect(user.accepts_sms).to eq(variables.accepts_sms)
    expect(user.profile_picture).to eq(variables.profile_picture)
  end

  it "returns errors" do
    variables = OpenStruct.new(
      email: 'someemail@example.com',
      password: 'password',
      first_name: 'John',
      last_name: 'Doe',
      authorized_users: ['Jane Doe'],
      phone_number: 'not a phone number',
      profile_picture: 'invalid url'
      )
    create(:user, email: variables.email)

    result = graphql(query: sign_up_mutation, variables: variables)

    errors = result.data.sign_up.errors
    expect(errors.first).to have_attributes(path: 'email', message: 'An account already exists for this email')
    expect(errors.second).to have_attributes(path: 'phoneNumber', message: 'Phone number must be 10 digits')
    expect(errors.third).to have_attributes(path: 'profilePicture', message: 'Profile picture must be a valid URL')
  end

  def sign_up_mutation
    <<~GQL
      mutation SignUp($email: String!, $password: String!, $firstName: String, $lastName: String, $authorizedUsers: [String!], $phoneNumber: String, $acceptsSms: Boolean, $profilePicture: String) {
        signUp(email: $email, password: $password, firstName: $firstName, lastName: $lastName, authorizedUsers: $authorizedUsers, phoneNumber: $phoneNumber, acceptsSms: $acceptsSms, profilePicture: $profilePicture) {
          user {
            email
            firstName
            lastName
            authorizedUsers
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