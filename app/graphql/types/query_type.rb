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
      argument :park_id, ID, "The ID of the park that you want to fetch users for. Leave empty to fetch users for all parks.", required: false
      argument :type, Types::UserEnum, "The type of user that you want to fetch. Leave empty to fetch all user types.", required: false
    end
    field :fetch_parks, [Types::Park], null: true do
      description "Fetch all parks"
    end
    field :fetch_activity_list, Types::FetchActivityList, null: true do
      description "Returns information about different activities. Activities include check-ins, sign-ins, and sign-ups."
      argument :park_id, ID, "The ID of the park that you want to fetch check-ins for. Leave empty to fetch check-ins for all parks.", required: false
      argument :type, Types::Activity, "The type of activity that you want to fetch information on", required: true
    end

    # Seems like this regression worked it's way back into graphql-ruby: https://github.com/rmosolgo/graphql-ruby/issues/788#issuecomment-308996229
    field :testInt, GraphQL::Types::Int, null: true

    def me
      context.current_user
    end

    def user_detail(id:)
      user = ::User.find(id).cast(includes: [:dogs])
    end

    def fetch_users(args = {})
      query = {}
      park_id = args[:park_id]
      type = args[:type]
      if park_id
        query[:park_id] = park_id
      end
      if type
        query[:type] = type
      end
      ::User.where(query)
    end

    def fetch_parks
      ::Park.all
    end

    def fetch_activity_list(args = {})
      park_id = args[:park_id]
      users = ::User.where(park_id: park_id)
      type = args[:type]
      items = []
      items = users.map do |user|
        binding.pry
        { user: user, activity_time: user.activity_time(type) }
      end
      { items: items, count: users.count }
    end

    def packages
      ::Package.fetch_all
    end
  end
end
