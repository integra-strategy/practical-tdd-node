class Types::Dog < Types::BaseObject

  field :id, ID, null: true
  field :user, Types::User, "The user that the dog belongs to", null: false
  field :profilePicture, Types::File, "The profile picture for the dog", null: true
  field :name, String, null: false
  field :age, Int, null: true
  field :sex, Types::Sex, null: true
  field :color, String, null: true
  field :rabies, GraphQL::Types::ISO8601DateTime, null: true
  field :dhlpp, GraphQL::Types::ISO8601DateTime, null: true
  field :leptospirosis, GraphQL::Types::ISO8601DateTime, null: true
  field :bordetella, GraphQL::Types::ISO8601DateTime, null: true
  field :separate_leptospirosis, Boolean, null: true
  field :vaccination_pictures, [Types::File], null: true
end