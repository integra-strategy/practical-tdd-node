class Mutations::UpdateUser < Mutations::BaseMutation

  description "Updates a user's information"

  argument :id, ID, required: true
  argument :address, String, required: false
  argument :address2, String, required: false
  argument :city, String, required: false
  argument :state, String, required: false
  argument :zip, String, required: false

  field :user, Types::UserType, null: true

  field :errors, [Types::UserError], null: false

  def resolve(attrs)
    user = User.find(attrs[:id])
    user.update_attributes(attrs.except(:id))
    errors = user.errors.map do |attribute, message|
      {
        path: attribute.to_s.camelize(:lower),
        message: message,
      }
    end
    return { user: {}, errors: errors } unless errors.empty?
    { user: user, errors: [] }
  end
end