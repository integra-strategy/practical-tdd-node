module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :me, Types::UserType, null: true
    field :member_detail, Types::MemberDetail, null: true

    def me
      context.current_user
    end

    def member_detail
      { first_name: 'John' }
    end
  end
end
