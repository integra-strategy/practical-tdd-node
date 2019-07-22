require 'stripe'

module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :me, Types::User, null: true
    field :user_detail, Types::User, null: true do
      description "Fetch details for a user by ID"
      argument :id, ID, required: true
    end
    field :packages, [Types::Package], null: true do
      description "Fetch available subscription packages"
    end
    field :fetch_users, [Types::User], null: true do
      description "Fetch users for a park"
      argument :park_id, ID, "The ID of the park that you want to fetch users for.", required: true
      argument :type, Types::UserEnum, "The type of user that you want to fetch.", required: false
    end

    # Seems like this regression worked it's way back into graphql-ruby: https://github.com/rmosolgo/graphql-ruby/issues/788#issuecomment-308996229
    field :testInt, GraphQL::Types::Int, null: true

    def me
      context.current_user
    end

    def user_detail(id:)
      user = ::User.find(id).cast(includes: [:dogs])
    end

    def fetch_users(args)
      query = { park_id: args.fetch(:park_id) }
      type = args[:type]
      if type
        query[:type] = type
      end
      ::User.where(query)
    end

    def packages
      ::Package.fetch_all
    end
  end
end
