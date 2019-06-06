RSpec.describe "GraphQlResponse" do
  it "serializes a GraphQL JSON response" do
    some_value = "Some value"

    result = Fetch::GraphQlResponse.parse({ someKey: { someNestedKey: some_value } }.to_json)

    expect(result.some_key.some_nested_key).to eq(some_value)
  end
end