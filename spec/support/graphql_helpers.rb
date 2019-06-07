module Fetch
  module GraphQlHelpers
    def graphql(query:, authentication_token: nil)
      post '/graphql', params: { query: query }, headers: { "Authorization": "Bearer #{authentication_token}" }
      throw UnauthorizedResponseError.new('Recevied 401 unauthorized from server') if response.status == 401
      ::Fetch::GraphQlResponse.parse(response.body)
    end

    class UnauthorizedResponseError < StandardError
    end
  end
end