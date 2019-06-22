require 'rails_helper'

RSpec.describe "Updating a dog", type: :request do
  it "updates the dog" do
    variables = {
      rabies: Time.zone.now.iso8601,
      dhlpp: Time.zone.now.iso8601, 
      leptospirosis: Time.zone.now.iso8601, 
      bordetella: Time.zone.now.iso8601,
      separate_leptospirosis: true,
      vaccination_image_urls: ['https://example.com']
    }
    dog = create(:dog, variables)

    result = update_dog(dog)

    expect(result.dog.id).to eq(dog.id.to_s)
    expect(result.dog).to have_attributes(variables)
  end

  it "handles errors" do
    dog = build(:dog)
    dog.id = 123

    result = update_dog(dog)

    error = result.errors.first
    expect(error.path).to eq('id')
    expect(error.message).to eq('dog not found')
  end

  def update_dog(dog)
    graphql(query: MUTATION, variables: OpenStruct.new(dog.attributes), user: dog.user).data.update_dog
  end

  MUTATION = <<~GQL
    mutation UpdateDog($id: ID!, $rabies: ISO8601DateTime, $dhlpp: ISO8601DateTime, $leptospirosis: ISO8601DateTime, $bordetella: ISO8601DateTime, $separateLeptospirosis: Boolean, $vaccinationImageUrls: [Url!]) {
      updateDog(id: $id, rabies: $rabies, dhlpp: $dhlpp, leptospirosis: $leptospirosis, bordetella: $bordetella, separateLeptospirosis: $separateLeptospirosis, vaccinationImageUrls: $vaccinationImageUrls) {
        dog {
          id
          rabies
          dhlpp
          leptospirosis
          bordetella
          separateLeptospirosis
          vaccinationImageUrls
        }
        errors {
          path
          message
        }
      }
    }
  GQL
end