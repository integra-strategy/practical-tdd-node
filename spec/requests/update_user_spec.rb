require 'rails_helper'

RSpec.describe "Update user", type: :request do
  it "supports updating a user" do
    authentication_token = fetch_authentication_token
    user = create(:user)
    variables = OpenStruct.new(
      id: user.id,
      first_name: 'John',
      last_name: 'Doe',
      authorized_users: ['Jane Doe'],
      address: FFaker::Address.street_address,
      address2: FFaker::Address.secondary_address,
      city: FFaker::Address.city,
      state: FFaker::AddressUS.state,
      zip: FFaker::AddressUS.zip_code,
      step: 2,
      completed: true,
      profile_picture: 'https://some.url.com'
    )

    result = graphql(query: update_user_mutation, variables: variables, authentication_token: authentication_token).data.update_user.user

    expect(result.first_name).to eq(variables.first_name)
    expect(result.last_name).to eq(variables.last_name)
    expect(result.authorized_users).to eq(variables.authorized_users)
    expect(result.address).to eq(variables.address)
    expect(result.address2).to eq(variables.address2)
    expect(result.city).to eq(variables.city)
    expect(result.state).to eq(variables.state)
    expect(result.zip).to eq(variables.zip)
    expect(result.step).to eq(variables.step)
    expect(result.completed).to eq(variables.completed)
    expect(result.profile_picture).to eq(variables.profile_picture)
  end

  it "returns errors" do
    user = create(:user)
    variables = OpenStruct.new(
      id: user.id,
      phone_number: 'not a phone number',
      profile_picture: 'invalid url'
      )

    result = graphql(query: update_user_mutation, variables: variables, authentication_token: fetch_authentication_token)

    errors = result.data.update_user.errors
    expect(errors.first).to have_attributes(path: 'profilePicture', message: 'Profile picture must be a valid URL')
  end

  def update_user_mutation
    <<~GQL
      mutation UpdateUser($id: ID!, $firstName: String, $lastName: String, $authorizedUsers: [String!], $address: String, $address2: String, $city: String, $state: String, $zip: String, $step: Int, $completed: Boolean, $profilePicture: String) {
        updateUser(id: $id, firstName: $firstName, lastName: $lastName, authorizedUsers: $authorizedUsers, address: $address, address2: $address2, city: $city, state: $state, zip: $zip, step: $step, completed: $completed, profilePicture: $profilePicture) {
          user {
            firstName
            lastName
            authorizedUsers
            address
            address2
            city
            state
            zip
            step
            completed
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