class Mutations::SignUp < Mutations::BaseMutation
  argument :email, String, required: true
  argument :password, String, required: true
  argument :first_name, String, required: true
  argument :last_name, String, required: true
  argument :authorized_users, [String], required: false
  argument :phone_number, String, required: false
  argument :profile_picture, String, required: false
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
    {
      user: user,
      errors: errors
    }
  end
end