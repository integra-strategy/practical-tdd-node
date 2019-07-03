require 'rails_helper'

RSpec.describe "Adding dogs", type: :request do
  it "supports adding multiple dogs at once" do
    filename = "file.txt"
    profile_picture = create_direct_upload(filename: filename)
    user = create(:member)
    variables = {
      user_id: user.id,
      profile_picture: profile_picture["signed_id"],
      name: 'Buddy',
      age: 3,
      sex: 'MALE',
      color: 'Golden'
    }

    result = add_dogs(variables: variables, user: user).dogs.first

    expect(result.user.id.to_i).to eq(user.id)
    expect(result.profile_picture.url).to eq("/rails/active_storage/blobs/#{profile_picture['signed_id']}/#{filename}")
    expect(result.profile_picture.name).to eq(filename)
    expect(result.name).to eq(variables[:name])
    expect(result.age).to eq(variables[:age])
    expect(result.sex).to eq(variables[:sex])
    expect(result.color).to eq(variables[:color])
  end

  def add_dogs(variables:, user:)
    mutation = <<~GQL
      mutation AddDogs($input: [CreateDog!]!) {
        addDogs(input: $input) {
          dogs {
            user {
              id
            }
            profilePicture {
              url
              name
            }
            name
            age
            sex
            color
          }
        }
      }
    GQL
    graphql(query: mutation, variables: OpenStruct.new({ input: [variables] })).data.add_dogs
  end
end