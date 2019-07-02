require 'rails_helper'

RSpec.describe "Updating a user", type: :request do
  it "supports updating a user" do
    user = create(:user)
    filename = 'file.txt'
    image = create_direct_upload(filename: filename)
    package = create_package(name: 'Some name')
    variables = OpenStruct.new(
      id: user.id,
      first_name: 'John',
      last_name: 'Doe',
      authorized_user: 'Jane Doe',
      address: FFaker::Address.street_address,
      address2: FFaker::Address.secondary_address,
      city: FFaker::Address.city,
      state: FFaker::AddressUS.state,
      zip: FFaker::AddressUS.zip_code,
      step: 2,
      completed: true,
      profile_picture: image["signed_id"],
      accepted_terms: true,
      phone_number: '1234567890',
      package: package.id
    )

    result = graphql(query: update_user_mutation, variables: variables, user: user).data.update_user.user

    expect(result.first_name).to eq(variables.first_name)
    expect(result.last_name).to eq(variables.last_name)
    expect(result.authorized_user).to eq(variables.authorized_user)
    expect(result.address).to eq(variables.address)
    expect(result.address2).to eq(variables.address2)
    expect(result.city).to eq(variables.city)
    expect(result.state).to eq(variables.state)
    expect(result.zip).to eq(variables.zip)
    expect(result.step).to eq(variables.step)
    expect(result.completed).to eq(variables.completed)
    expect(result.profile_picture.url).to eq("/rails/active_storage/blobs/#{image['signed_id']}/#{filename}")
    expect(result.profile_picture.name).to eq(filename)
    expect(result.accepted_terms).to eq(variables.accepted_terms)
    expect(result.phone_number).to eq(variables.phone_number)
    expect(result.package.id).to eq(package.id)
  end

  it "returns errors" do
    user = create(:user)
    variables = OpenStruct.new(
      id: user.id,
      phone_number: 'not a phone number'
      )

    result = graphql(query: update_user_mutation, variables: variables, user: user)

    errors = result.data.update_user.errors
    expect(errors.first).to have_attributes(path: 'phoneNumber', message: 'Phone number must be 10 digits')
  end

  def update_user_mutation
    <<~GQL
      mutation UpdateUser($id: ID!, $firstName: String, $lastName: String, $authorizedUser: String, $address: String, $address2: String, $city: String, $state: String, $zip: String, $step: Int, $completed: Boolean, $profilePicture: String, $acceptedTerms: Boolean, $phoneNumber: String, $package: ID) {
        updateUser(id: $id, firstName: $firstName, lastName: $lastName, authorizedUser: $authorizedUser, address: $address, address2: $address2, city: $city, state: $state, zip: $zip, step: $step, completed: $completed, profilePicture: $profilePicture, acceptedTerms: $acceptedTerms, phoneNumber: $phoneNumber, package: $package) {
          user {
            firstName
            lastName
            authorizedUser
            address
            address2
            city
            state
            zip
            step
            completed
            profilePicture {
              url
              name
            }
            acceptedTerms
            phoneNumber
            package {
              id
            }
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