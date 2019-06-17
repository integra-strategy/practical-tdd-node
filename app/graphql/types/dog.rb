class Types::Dog < Types::BaseObject

  description 'Dog type'

  field :id, ID, null: false
  field :user, Types::UserType, "The user that the dog belongs to", null: false
  field :picture, String, null: true
  field :name, String, null: false
  field :age, Int, "How old the dog is (in human years)", null: true
  field :sex, Types::Sex, "The sex of the dog", null: true
  field :color, String, "The color of the dog", null: true
end