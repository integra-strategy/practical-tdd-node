require 'rails_helper'

RSpec.describe "Updating a dog", type: :request do
  it "updates the dog" do
    dog = create(:dog)
    variables = OpenStruct.new(
      id: dog.id,
      rabies: Time.zone.now.iso8601,
      dhlpp: Time.zone.now.iso8601, 
      leptospirosis: Time.zone.now.iso8601, 
      bordetella: Time.zone.now.iso8601,
      separate_leptospirosis: true,
      vaccination_image_urls: ['https://example.com']
    )
    result = update_dog(dog, variables)

    expect(result.dog.id).to eq(dog.id.to_s)
    expect(result.dog.rabies).to eq(variables.rabies)
    expect(result.dog.dhlpp).to eq(variables.dhlpp)
    expect(result.dog.leptospirosis).to eq(variables.leptospirosis)
    expect(result.dog.bordetella).to eq(variables.bordetella)
    expect(result.dog.separate_leptospirosis).to eq(variables.separate_leptospirosis)
    expect(result.dog.vaccination_image_urls).to eq(variables.vaccination_image_urls)
  end

  def update_dog(dog, variables)
    graphql(query: MUTATION, variables: variables, user: dog.user).data.update_dog
  end

  MUTATION = <<~GQL
    mutation UpdateDog($id: ID!, $rabies: ISO8601DateTime, $dhlpp: ISO8601DateTime, $leptospirosis: ISO8601DateTime, $bordetella: ISO8601DateTime, $separateLeptospirosis: Boolean, $vaccinationImageUrls: [String!]) {
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
      }
    }
  GQL
end