require 'rails_helper'

RSpec.describe "Fetching users", type: :request do
  it "returns users for the specified park and type" do
    park_a = create(:park)
    park_b = create(:park)
    park_a_member = create(:member, park: park_a)
    create(:member, park: park_b)
    variables = {
      park_id: park_a.id
    }

    results = fetch_users(variables)

    expect(results.length).to eq(1)
    expect(results.first.id).to eq(park_a_member.id.to_s)
  end

  def fetch_users(variables)
    query = <<~GQL
      query FetchUsers($parkId: ID!) {
        fetchUsers(parkId: $parkId) {
          id
          type
        }
      }
    GQL
    graphql(query: query, variables: OpenStruct.new(variables)).data.fetch_users
  end
end