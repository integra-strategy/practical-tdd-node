class Types::Package < Types::BaseObject
  field :id, ID, "The ID of the package on Stripe", null: false
  field :name, String, "The name of the package", null: false
  field :amount, Integer, "The amount of the package", null: false
  field :description, [String], "An array of strings describing the package meant to be used as bullet points.", null: false
end