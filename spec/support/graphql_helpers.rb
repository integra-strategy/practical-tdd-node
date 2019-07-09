module Fetch
  module GraphQlHelpers
    def graphql(query:, variables: { "table": {} }, user: create(:member), throw_errors: true)
      formatted_variables = variables.as_json["table"].deep_transform_keys { |k| k.camelcase(:lower) }
      user.ensure_authentication_token!
      headers = { "Authorization": "Bearer #{user.authentication_token}", "Accept": "application/json", "CONTENT_TYPE": "application/json" }
      # We have to do this in order to get Rails to post the data as JSON https://stackoverflow.com/a/44752082/1852466
      post '/graphql', params: { query: query, variables: formatted_variables }.to_json, headers: headers
      if response.status == 401
        throw UnauthorizedResponseError.new('Recevied 401 unauthorized from server')
      end
      parsed_body = ::Fetch::GraphQlResponse.parse(response.body)
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