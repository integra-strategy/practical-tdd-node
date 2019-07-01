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

    # Seems like this regression worked it's way back into graphql-ruby: https://github.com/rmosolgo/graphql-ruby/issues/788#issuecomment-308996229
    field :testInt, GraphQL::Types::Int, null: true

    def me
      context.current_user
    end

    def user_detail(id:)
      user = ::User.includes(:dogs).find(id)
      user.to_graphql.merge(package: ::Package.fetch(user.package))
    end

    def packages
      Stripe::Plan.list(limit: 10)
    end
  end
end
