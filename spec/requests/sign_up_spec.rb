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
      profile_picture: 'https://some.url.com',
      address: '123 Somewhere',
      address2: 'Suite #1000',
      city: 'Some City',
      state: 'Some State',
      zip: '12345'
    )

    result = graphql(query: sign_up_mutation, variables: variables)

    user = result.data.sign_up.user
    expect(user.email).to eq(variables.email)
    expect(user.first_name).to eq(variables.first_name)
    expect(user.last_name).to eq(variables.last_name)
    expect(user.authorized_users).to eq(variables.authorized_users)
    expect(user.profile_picture).to eq(variables.profile_picture)
    expect(user.address).to eq(variables.address)
    expect(user.address2).to eq(variables.address2)
    expect(user.city).to eq(variables.city)
    expect(user.state).to eq(variables.state)
    expect(user.zip).to eq(variables.zip)
  end

  it "returns errors" do
    variables = OpenStruct.new(
      email: 'someemail@example.com',
      password: 'password',
      first_name: 'John',
      last_name: 'Doe',
      authorized_users: ['Jane Doe'],
      phone_number: 'not a phone number',
      profile_picture: 'invalid url',
      address: '123 Somewhere',
      address2: 'Suite #1000',
      city: 'Some City',
      state: 'Some State',
      zip: '12345'
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
      mutation SignUp($email: String!, $password: String!, $firstName: String!, $lastName: String!, $authorizedUsers: [String!], $phoneNumber: String, $profilePicture: String, $address: String, $address2: String, $city: String, $state: String, $zip: String) {
        signUp(email: $email, password: $password, firstName: $firstName, lastName: $lastName, authorizedUsers: $authorizedUsers, phoneNumber: $phoneNumber, profilePicture: $profilePicture, address: $address, address2: $address2, city: $city, state: $state, zip: $zip) {
          user {
            email
            firstName
            lastName
            authorizedUsers
            phoneNumber
            profilePicture
            address
            address2
            city
            state
            zip
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