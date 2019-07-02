require 'rails_helper'

RSpec.describe "User detail", type: :request do
  it "returns details about the user" do
    package = create_package
    user = create(:user, first_name: "John", package: package.id)
    dog = create(:dog, user: user)
    variables = OpenStruct.new(id: user.id)

    result = user_detail(variables: variables, user: user)

    expect(result.first_name).to eq(user.first_name)
    expect(result.dogs.first.id.to_i).to eq(dog.id)
    expect(result.package.id).to eq(package.id)
  end

  def user_detail(variables:, user:)
    graphql(query: user_detail_query, variables: variables, user: user).data.user_detail
  end
end
