class Mutations::UpdateDog < Mutations::BaseMutation

  description "Update a dog"

  argument :id, ID, required: true
  argument :rabies, GraphQL::Types::ISO8601DateTime, required: false
  argument :dhlpp, GraphQL::Types::ISO8601DateTime, required: false
  argument :leptospirosis, GraphQL::Types::ISO8601DateTime, required: false
  argument :bordetella, GraphQL::Types::ISO8601DateTime, required: false
  argument :separate_leptospirosis, GraphQL::Types::Boolean, required: false
  argument :vaccination_image_urls, [String], required: false

  field :dog, Types::Dog, null: true

  def resolve(args)
    id = args[:id]
    dog = Dog.find(id)
    dog.update(args.except(:id))
    dog.reload
    { dog: dog }
  end
end