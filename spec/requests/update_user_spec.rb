require 'rails_helper'

RSpec.describe "Updating a user", type: :request do
  it "supports updating a user" do
    user = create(:user)
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
      profile_picture: 'https://some.url.com',
      accepted_terms: true,
      package: Types::Package::DAILY.to_s
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
    expect(result.profile_picture).to eq(variables.profile_picture)
    expect(result.accepted_terms).to eq(variables.accepted_terms)
    expect(result.package).to eq(variables.package)
  end

  def update_user_mutation
    <<~GQL
      mutation UpdateUser($id: ID!, $firstName: String, $lastName: String, $authorizedUser: String, $address: String, $address2: String, $city: String, $state: String, $zip: String, $step: Int, $completed: Boolean, $profilePicture: Url, $acceptedTerms: Boolean, $receivesLowerPrice: Boolean, $package: Package) {
        updateUser(id: $id, firstName: $firstName, lastName: $lastName, authorizedUser: $authorizedUser, address: $address, address2: $address2, city: $city, state: $state, zip: $zip, step: $step, completed: $completed, profilePicture: $profilePicture, acceptedTerms: $acceptedTerms, receivesLowerPrice: $receivesLowerPrice, package: $package) {
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
            profilePicture
            acceptedTerms
            receivesLowerPrice
            package
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