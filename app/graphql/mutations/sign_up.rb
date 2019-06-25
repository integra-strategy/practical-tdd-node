class Mutations::SignUp < Mutations::BaseMutation

  description "Signs a user up"

  argument :email, String, required: true
  argument :password, String, required: true
  argument :password_confirmation, String, required: true
  argument :phone_number, String, "10 digit phone number for user", required: false
  argument :accepts_sms, Boolean, "whether or not the user has agreed to receive SMS for updates and specials", required: false

  field :user, Types::User, null: true
  field :auth, Types::AuthType, null: true
  field :errors, [Types::UserError], null: false

  def resolve(attrs)
    user = Member.new(attrs)
    user.skip_confirmation_notification!
    user.save
    result = { errors: user.graphql_errors }
    result.tap do |r|
      if user.valid?
        r[:user] = user
        user.ensure_authentication_token!
        r[:auth] = { authentication_token: user.authentication_token }
      end
    end
  end
end