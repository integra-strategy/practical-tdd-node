
class Mutations::UpdateUser < Mutations::BaseMutation

  description "Updates a user's information. If using this mutation as part of the sign up flow, be sure to include the step and whether or not the user has completed their sign up."

  STEP_DESCRIPTION = "The step of the sign up process that the user has completed. This is used to track where the user should be taken back to if they come back to the app."
  COMPLETED_DESCRIPTION = "Whether or not the user has completed the sign up process."

  argument :id, ID, required: true
  argument :address, String, required: false
  argument :address2, String, required: false
  argument :city, String, required: false
  argument :state, String, required: false
  argument :zip, String, required: false
  argument :step, Int, STEP_DESCRIPTION, required: false
  argument :completed, Boolean, COMPLETED_DESCRIPTION, required: false

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