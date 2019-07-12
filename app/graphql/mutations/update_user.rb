
class Mutations::UpdateUser < Mutations::BaseMutation

  description "Updates a user's information. If using this mutation as part of the sign up flow, be sure to include the step and whether or not the user has completed their sign up."

  argument :input, Inputs::UpdateUser, required: false
  field :user, Types::User, null: true

  field :errors, [Types::UserError], null: false

  def resolve(input:)
    user = User.find(input[:id])
    user.update_attributes(input.to_h.except(:id))
    { user: user.to_graphql, errors: user.graphql_errors }
  end
end