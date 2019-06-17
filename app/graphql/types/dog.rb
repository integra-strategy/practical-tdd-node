class Types::Dog < Types::BaseObject

  field :id, ID, null: false
  field :user, Types::UserType, "The user that the dog belongs to", null: false
  field :picture, String, "URL of a picture of the dog", null: true
  field :name, String, null: false
  field :age, Int, null: true
  field :sex, Types::Sex, null: true
  field :color, String, null: true
end