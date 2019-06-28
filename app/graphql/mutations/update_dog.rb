class Mutations::UpdateDog < Mutations::BaseMutation

  description "Update a dog"

  argument :id, ID, required: true
  argument :rabies, GraphQL::Types::ISO8601DateTime, required: false
  argument :dhlpp, GraphQL::Types::ISO8601DateTime, required: false
  argument :leptospirosis, GraphQL::Types::ISO8601DateTime, required: false
  argument :bordetella, GraphQL::Types::ISO8601DateTime, required: false
  argument :separate_leptospirosis, GraphQL::Types::Boolean, required: false
  argument :vaccination_images, [String], required: false

  field :dog, Types::Dog, null: true
  field :errors, [Types::UserError], null: false

  def resolve(args)
    id = args[:id]
    dog = Dog.where(id: id).first || NilDog.new
    dog.update(args.except(:id))
    { dog: dog.attributes, errors: dog.graphql_errors }
  end
end