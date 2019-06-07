RSpec.describe "General API functionality", type: :request do
  it "rejects unauthenticated requests" do

    post '/graphql', params: { query: user_detail_query }

    expect(response.status).to eq(401)
  end

  it "rejects queries with no operation name" do
    query = <<-QUERY
      {
        userDetail {
          firstName
        }
      }
    QUERY

    result = graphql(query: query, throw_errors: false)

    expect(response.status).to eq(422)
    expect(result.errors.first.message).to eq("Please provide an operation name for the following query: #{query}")
  end
end