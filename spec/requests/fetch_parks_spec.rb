require 'rails_helper'

RSpec.describe "Fetching parks", type: :request do
  it "returns all of the parks" do
    park_a = create(:park)
    park_b = create(:park)

    results = fetch_parks

    expect(results.length).to eq(3) # Includes the park created when creating the signed in user
    expect(results.first.id).to eq(park_a.id.to_s)
  end

  def fetch_parks(variables = {})
    query = <<~GQL
      query FetchParks {
        fetchParks {
          id
        }
      }
    GQL
    graphql(query: query, variables: OpenStruct.new(variables)).data.fetch_parks
  end
end