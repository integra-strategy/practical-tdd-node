module Fetch
  module GraphQlHelpers
    def graphql(query:, authentication_token: nil, throw_errors: true)
      post '/graphql', params: { query: query }, headers: { "Authorization": "Bearer #{authentication_token}", "Accept": "application/json" }
      parsed_body = ::Fetch::GraphQlResponse.parse(response.body)
      if response.status == 401
        throw UnauthorizedResponseError.new('Recevied 401 unauthorized from server')
      end
      unless parsed_body.errors.empty? || !throw_errors
        throw GraphQlResponseError.new(parsed_body.errors.first.message)
      end
      parsed_body
    end

    class UnauthorizedResponseError < StandardError
    end

    class GraphQlResponseError < StandardError
    end
  end
end