class Types::FetchActivityListItem < Types::BaseObject
  field :user, Types::User, null: false
  field :time, String, null: false
end