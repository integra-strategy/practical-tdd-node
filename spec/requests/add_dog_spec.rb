require 'rails_helper'

RSpec.describe "Adding a dog", type: :request do
  it "supports adding a dog" do
    filename = "file.txt"
    profile_picture = create_direct_upload(filename: filename)
    user = create(:user)
    variables = OpenStruct.new(
      userId: user.id,
      profile_picture: profile_picture["signed_id"],
      name: 'Buddy',
      age: 3,
      sex: 'MALE',
      color: 'Golden'
    )

    result = graphql(query: add_dog, variables: variables, user: user).data.add_dog.dog

    expect(result.user.id.to_i).to eq(user.id)
    expect(result.profile_picture.url).to eq("/rails/active_storage/blobs/#{profile_picture['signed_id']}/#{filename}")
    expect(result.profile_picture.name).to eq(filename)
    expect(result.name).to eq(variables.name)
    expect(result.age).to eq(variables.age)
    expect(result.sex).to eq(variables.sex)
    expect(result.color).to eq(variables.color)
  end

  def add_dog
    <<~GQL
      mutation AddDog($userId: ID!, $profilePicture: String, $name: String!, $age: Int, $sex: Sex, $color: String) {
        addDog(userId: $userId, profilePicture: $profilePicture, name: $name, age: $age, sex: $sex, color: $color) {
          dog {
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
  end
end