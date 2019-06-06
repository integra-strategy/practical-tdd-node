RSpec.describe "General API functionality", type: :request do
  it "rejects unauthenticated requests" do

    post '/graphql', params: { query: user_detail_query, operationName: 'userDetail' }

    expect(response.status).to eq(401)
  end
end