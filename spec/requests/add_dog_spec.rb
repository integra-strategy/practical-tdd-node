require 'rails_helper'

RSpec.describe "Adding a dog", type: :request do
  it "supports adding a dog" do
    user = create(:user)
    variables = OpenStruct.new(
      userId: user.id,
      picture: 'https://example.com',
      name: 'Buddy',
      age: 3,
      sex: 'MALE',
      color: 'Golden'
    )

    result = graphql(query: add_dog, variables: variables, user: user).data.add_dog.dog

    expect(result.user.id.to_i).to eq(user.id)
    expect(result.picture).to eq(variables.picture)
    expect(result.name).to eq(variables.name)
    expect(result.age).to eq(variables.age)
    expect(result.sex).to eq(variables.sex)
    expect(result.color).to eq(variables.color)
  end

  def add_dog
    <<~GQL
      mutation AddDog($userId: ID!, $picture: String, $name: String!, $age: Int, $sex: Sex, $color: String) {
        addDog(userId: $userId, picture: $picture, name: $name, age: $age, sex: $sex, color: $color) {
          dog {
            user {
              id
            }
            picture
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