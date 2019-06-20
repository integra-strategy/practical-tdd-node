class Mutations::SignUp < Mutations::BaseMutation

  description "Signs a user up"

  argument :email, String, required: true
  argument :password, String, required: true
  argument :password_confirmation, String, required: true
  argument :phone_number, String, "10 digit phone number for user", required: false
  argument :accepts_sms, Boolean, "whether or not the user has agreed to receive SMS for updates and specials", required: false

  field :user, Types::User, null: true

  field :errors, [Types::UserError], null: false

  def resolve(attrs)
    user = Member.new(attrs)
    user.skip_confirmation_notification!
    user.save
    { user: user, errors: user.graphql_errors }
  end
end