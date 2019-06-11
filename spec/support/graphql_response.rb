require 'ostruct'

module Fetch
  class GraphQlResponse
    def self.parse(json_string)
      snake_case_json = JSON.parse(json_string).deep_transform_keys(&:underscore).to_json
      json = JSON.parse(snake_case_json, object_class: OpenStruct)
      unless json.errors
        json.errors = []
      end
      OpenStruct.new(json)
    end
  end
end