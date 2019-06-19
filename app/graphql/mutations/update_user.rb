
class Mutations::UpdateUser < Mutations::BaseMutation

  description "Updates a user's information. If using this mutation as part of the sign up flow, be sure to include the step and whether or not the user has completed their sign up."

  STEP_DESCRIPTION = "The step of the sign up process that the user has completed. This is used to track what screen the user should be taken back to if they stop the sign up process and then come back to it."
  COMPLETED_DESCRIPTION = "Whether or not the user has completed the sign up process."

  argument :id, ID, required: true
  argument :first_name, String, required: false
  argument :last_name, String, required: false
  argument :authorized_user, String, "The names of users that are authorized to take the user's dog to the park", required: false
  argument :address, String, required: false
  argument :address2, String, required: false
  argument :city, String, required: false
  argument :state, String, required: false
  argument :zip, String, required: false
  argument :step, Int, STEP_DESCRIPTION, required: false
  argument :completed, Boolean, COMPLETED_DESCRIPTION, required: false
  argument :profile_picture, String, "a URL of the profile picture for the user", required: false
  argument :accepted_terms, Boolean, "Whether or not the user has accepted the terms and conditions", required: false
  argument :receives_lower_price, Boolean, "Whether or not the user receives a lower price. If a user had an account before the app was created, then they are grandfathered in and receive a lower price until the end of 2019.", required: false
  argument :package, Types::Package, "The payment package that the user selected when signing up", required: false

  field :user, Types::User, null: true

  field :errors, [Types::UserError], null: false

  def resolve(attrs)
    user = User.find(attrs[:id])
    user.update_attributes(attrs.except(:id))
    { user: user, errors: user.graphql_errors }
  end
end