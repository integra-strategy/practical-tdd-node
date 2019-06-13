class Mutations::SignUp < Mutations::BaseMutation

  description "Signs a user up"

  argument :email, String, required: true
  argument :password, String, required: true
  argument :phone_number, String, "10 digit phone number for user", required: false
  argument :accepts_sms, Boolean, "whether or not the user has agreed to receive SMS for updates and specials", required: false

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