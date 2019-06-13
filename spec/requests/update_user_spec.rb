require 'rails_helper'

RSpec.describe "Update user", type: :request do
  it "supports updating a user" do
    authentication_token = fetch_authentication_token
    user = create(:user)
    variables = OpenStruct.new(
      id: user.id,
      address: FFaker::Address.street_address,
      address2: FFaker::Address.secondary_address,
      city: FFaker::Address.city,
      state: FFaker::Address.us_state,
      zip: FFaker::AddressUS.zip_code,
      step: 2,
      completed: true
    )

    result = graphql(query: update_user_mutation, variables: variables, authentication_token: authentication_token).data.update_user.user

    expect(result.address).to eq(variables.address)
    expect(result.address2).to eq(variables.address2)
    expect(result.city).to eq(variables.city)
    expect(result.state).to eq(variables.state)
    expect(result.zip).to eq(variables.zip)
    expect(result.step).to eq(variables.step)
    expect(result.completed).to eq(variables.completed)
  end

  def update_user_mutation
    <<~GQL
      mutation UpdateUser($id: ID!, $address: String, $address2: String, $city: String, $state: String, $zip: String, $step: Int, $completed: Boolean) {
        updateUser(id: $id, address: $address, address2: $address2, city: $city, state: $state, zip: $zip, step: $step, completed: $completed) {
          user {
            address
            address2
            city
            state
            zip
            step
            completed
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