class FetchApiContext < GraphQL::Query::Context
  def current_user
    self[:current_user]
  end

  def current_ability
    self[:current_ability]
  end
end
