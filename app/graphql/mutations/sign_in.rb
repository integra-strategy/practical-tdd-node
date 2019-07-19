class Mutations::SignIn < Mutations::BaseMutation

  description "Signs a user in"

  argument :email, String, required: true
  argument :password, String, required: true

  field :auth, Types::AuthType, null: false
  field :user, Types::User, null: false

  def resolve(email:, password:)
    if user = User.find_for_database_authentication(email: email)
      if user.deactivated?
        return GraphQL::ExecutionError.new('There was a problem signing-in. Please see a manager or admin.')
      end
      if user.valid_password?(password)
        user.ensure_authentication_token!
        authentication_token = user.authentication_token
        return OpenStruct.new(user: user, auth: { authentication_token: authentication_token })
      else
        GraphQL::ExecutionError.new('Incorrect Email/Password')
      end
    else
      GraphQL::ExecutionError.new('User not registered on this application')
    end
  end
end