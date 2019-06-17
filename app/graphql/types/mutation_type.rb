module Types
  class MutationType < Types::BaseObject
    field :sign_in, mutation: Mutations::SignIn
    field :sign_up, mutation: Mutations::SignUp
    field :update_user, mutation: Mutations::UpdateUser
    field :add_dog, mutation: Mutations::AddDog
  end
end
