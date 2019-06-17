require 'rails_helper'

RSpec.describe "User detail", type: :request do
  it "returns details about the user" do
    user = create(:user, first_name: "John")
    variables = OpenStruct.new(id: user.id)

    result = graphql(query: user_detail_query, variables: variables, user: user)

    expect(result.data.user_detail.first_name).to eq(user.first_name)
  end
end
