class Mutations::CreateManager < Mutations::BaseMutation
  argument :input, Inputs::CreateManager, required: true

  field :user, Types::User, null: true
  field :errors, [Types::UserError], null: true

  def resolve(input:)
    manager = Manager.new(input.to_h)
    manager.skip_confirmation_notification!
    manager.skip_confirmation!
    manager.save
    { user: manager }
  end
end