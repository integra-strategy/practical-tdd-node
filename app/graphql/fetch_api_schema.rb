class FetchApiSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
  context_class(FetchApiContext)
end
