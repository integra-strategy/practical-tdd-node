class Mutations::SignUp < Mutations::BaseMutation

  description "Signs a user up"

  argument :email, String, required: true
  argument :password, String, required: true
  argument :first_name, String, required: false
  argument :last_name, String, required: false
  argument :authorized_users, [String], "The names of users that are authorized to take the user's dog to the park", required: false
  argument :phone_number, String, "10 digit phone number for user", required: false
  argument :accepts_sms, Boolean, "whether or not the user has agreed to receive SMS", required: false
  argument :profile_picture, String, "a URL of the profile picture for the user", required: false
  argument :address, String, required: false
  argument :address2, String, required: false
  argument :city, String, required: false
  argument :state, String, required: false
  argument :zip, String, required: false

  field :user, Types::UserType, null: true

  field :errors, [Types::UserError], null: false

  def resolve(attrs)
    user = User.create(attrs)
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