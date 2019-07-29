class Types::CheckIn < Types::BaseObject
  field :user, Types::User, "The user who checked-in.", null: true
end