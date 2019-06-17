class Mutations::AddDog < Mutations::BaseMutation

  description "Adds a dog for a user"

  argument :user_id, ID, "The user that the dog belongs to", required: true
  argument :picture, String, "URL of a picture of the dog", required: false
  argument :name, String, required: true
  argument :age, Int, "How old the dog is (in human years)", required: false
  argument :sex, Types::Sex, "The sex of the dog", required: false
  argument :color, String, "The color of the dog", required: false

  field :dog, Types::Dog, null: true
  field :errors, [Types::UserError], null: true

  def resolve(*attrs)
    dog = Dog.new(*attrs)
    dog.save!
    { dog: dog, errors: dog.graphql_errors }
  end
end