class Types::Package < Types::BaseObject
  field :id, ID, "The ID of the package on Stripe", null: false
  field :name, String, "The name of the package", null: false
end