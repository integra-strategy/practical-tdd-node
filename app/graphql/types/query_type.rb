module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :me, Types::UserType, null: true
    field :user_detail, Types::UserType, null: true

    def me
      context.current_user
    end

    def user_detail
      User.first
    end
  end
end
