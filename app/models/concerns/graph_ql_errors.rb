module GraphQlErrors
  extend ActiveSupport::Concern

  def graphql_errors
    self.errors.map do |attribute, message|
      {
        path: attribute.to_s.camelize(:lower),
        message: message,
      }
    end
  end
end