require 'rails_helper'

RSpec.describe "Members", type: :request do
  describe "Signing In" do
    it "returns an authentication token" do
      email = 'someemail@example.com'
      password = 'password'
      member = create(:member, email: email, password: password)

      result = graphql(query(email: email, password: password))

      expect(result.errors).to be_nil
      expect(result.data.sign_in.authentication_token).to be_truthy
    end
  end
end


def query(email:, password:)
  <<~GQL
    mutation {
      signIn(email: "#{email}", password: #{password}) {
        authenticationToken
      }
    }
  GQL
end

def graphql(query)
  post '/graphql', params: { query: query }
  GraphQlResponse.parse(response.body)
end