module Types
  class MutationType < Types::BaseObject
    field :sign_in, mutation: Mutations::SignIn
    field :sign_up, mutation: Mutations::SignUp
    field :update_user, mutation: Mutations::UpdateUser
    field :add_dogs, mutation: Mutations::AddDogs
    field :update_dog, mutation: Mutations::UpdateDog
    field :confirm_member, mutation: Mutations::ConfirmMember
    field :send_verification_code, mutation: Mutations::SendVerificationCode
    field :submit_verification_code, mutation: Mutations::SubmitVerificationCode
    field :create_manager, mutation: Mutations::CreateManager
  end
end
