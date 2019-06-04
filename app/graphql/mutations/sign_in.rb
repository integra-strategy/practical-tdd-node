class Mutations::SignIn < Mutations::BaseMutation

  argument :email, String, required: true
  argument :password, String, required: true

  type Types::AuthType

  def resolve(email:, password:)
    if member = Member.find_for_database_authentication(email: email)
      if member.valid_password?(password)
        member.ensure_authentication_token!
        authentication_token = member.authentication_token
        return OpenStruct.new(authentication_token: authentication_token)
      else
        GraphQL::ExecutionError.new('Incorrect Email/Password')
      end
    else
      GraphQL::ExecutionError.new('member not registered on this application')
    end
  end
end