require 'rails_helper'

RSpec.describe "Sign up", type: :request do
  it "supports signing up with basic info" do
    variables = OpenStruct.new(
      email: 'someemail@example.com',
      password: 'password',
      first_name: 'John',
      last_name: 'Doe',
      authorized_users: ['Jane Doe'],
      phone_number: '1234567890',
      profile_picture: 'https://some.url.com',
      address: '123 Somewhere',
      address2: 'Suite #1000',
      city: 'Some City',
      state: 'Some State',
      zip: '12345'
    )

    result = graphql(query: sign_up_mutation, variables: variables)

    user = result.data.sign_up
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

  def sign_up_mutation
    <<~GQL
      mutation SignUp($email: String!, $password: String!, $firstName: String!, $lastName: String!, $authorizedUsers: [String!], $profilePicture: String, $address: String, $address2: String, $city: String, $state: String, $zip: String) {
        signUp(email: $email, password: $password, firstName: $firstName, lastName: $lastName, authorizedUsers: $authorizedUsers, profilePicture: $profilePicture, address: $address, address2: $address2, city: $city, state: $state, zip: $zip) {
          email
          firstName
          lastName
          authorizedUsers
          profilePicture
          address
          address2
          city
          state
          zip
        }
      }
    GQL
  end
end