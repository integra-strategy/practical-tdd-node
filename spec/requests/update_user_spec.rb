require 'rails_helper'

RSpec.describe "Updating a user", type: :request do
  it "supports updating a user" do
    user = create(:member)
    filename = 'file.txt'
    image = create_direct_upload(filename: filename)
    package = create(:stripe_plan, name: 'Some name')
    park = create(:park)
    positions = ['Cashier']
    hire_date = Time.zone.now
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
      package_id: package.id,
      stripe_card_token: 'some token',
      notes: 'Some note',
      park_id: park.id,
      positions: positions,
      hire_date: hire_date.iso8601
    )

    result = update_user(variables: variables, user: user).user

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
    expect(result.notes).to eq(variables.notes)
    expect(result.park.id).to eq(park.id.to_s)
    expect(result.positions).to eq(positions)
    expect(result.hire_date).to include(hire_date.strftime('%Y-%m-%d %H:%M:%S'))
  end

  it "returns errors" do
    user = create(:member)
    variables = OpenStruct.new(
      id: user.id,
      phone_number: 'not a phone number'
    )

    results = update_user(variables: variables, user: user).errors

    expect(results.first).to have_attributes(path: 'phoneNumber', message: 'Phone number must be 10 digits')
  end

  def update_user(variables:, user:)
    mutation = <<~GQL
      mutation UpdateUser($input: UpdateUser) {
        updateUser(input: $input) {
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
            notes
            park {
              id
            }
            positions
            hireDate
          }
          errors {
            path
            message
          }
        }
      }
    GQL
    graphql(query: mutation, variables: OpenStruct.new(input: variables.as_json["table"]), user: user).data.update_user
  end
end