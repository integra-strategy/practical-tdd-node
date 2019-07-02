require 'rails_helper'

RSpec.describe "Updating a dog", type: :request do
  it "updates the dog" do
    filename = 'file.txt'
    vaccination_picture = create_direct_upload(filename: filename)
    dog = create(
      :dog,
      rabies: Time.zone.now.iso8601,
      dhlpp: Time.zone.now.iso8601, 
      leptospirosis: Time.zone.now.iso8601, 
      bordetella: Time.zone.now.iso8601,
      separate_leptospirosis: true
    )

    result = update_dog(dog, { vaccination_pictures: [vaccination_picture["signed_id"]] })

    expect(result.dog.id).to eq(dog.id.to_s)
    expect(result.dog.rabies).to eq(dog.rabies.iso8601)
    expect(result.dog.dhlpp).to eq(dog.dhlpp.iso8601)
    expect(result.dog.leptospirosis).to eq(dog.leptospirosis.iso8601)
    expect(result.dog.bordetella).to eq(dog.bordetella.iso8601)
    expect(result.dog.separate_leptospirosis).to eq(dog.separate_leptospirosis)
    expect(result.dog.vaccination_pictures.first.url).to eq("/rails/active_storage/blobs/#{vaccination_picture['signed_id']}/#{filename}")
    expect(result.dog.vaccination_pictures.first.name).to eq(filename)
  end

  it "handles errors" do
    dog = build(:dog)
    dog.id = 123

    result = update_dog(dog)

    error = result.errors.first
    expect(error.path).to eq('id')
    expect(error.message).to eq('dog not found')
  end

  def update_dog(dog, variables = {})
    graphql(query: MUTATION, variables: OpenStruct.new(dog.attributes.merge(variables)), user: dog.user).data.update_dog
  end

  MUTATION = <<~GQL
    mutation UpdateDog($id: ID!, $rabies: ISO8601DateTime, $dhlpp: ISO8601DateTime, $leptospirosis: ISO8601DateTime, $bordetella: ISO8601DateTime, $separateLeptospirosis: Boolean, $vaccinationPictures: [String!]) {
      updateDog(id: $id, rabies: $rabies, dhlpp: $dhlpp, leptospirosis: $leptospirosis, bordetella: $bordetella, separateLeptospirosis: $separateLeptospirosis, vaccinationPictures: $vaccinationPictures) {
        dog {
          id
          rabies
          dhlpp
          leptospirosis
          bordetella
          separateLeptospirosis
          vaccinationPictures {
            url
            name
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