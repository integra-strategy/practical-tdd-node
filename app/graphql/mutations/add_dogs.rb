class Mutations::AddDogs < Mutations::BaseMutation

  description "Adds dogs for a user"

  argument :input, [Inputs::CreateDog], required: true

  field :dogs, [Types::Dog], null: true

  def resolve(**attrs)
    parsed_attrs = attrs[:input].map do |input|
      {
        user_id: input.user_id,
        profile_picture: input.profile_picture,
        name: input.name,
        age: input.age,
        sex: input.sex,
        color: input.color
      }
    end
    dogs = Dog.create(parsed_attrs)
    { dogs: dogs.map(&:to_graphql) }
  end
end