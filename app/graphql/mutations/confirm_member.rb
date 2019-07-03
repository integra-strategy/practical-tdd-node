class Mutations::ConfirmMember < Mutations::BaseMutation
  argument :input, Types::ConfirmMember, required: true

  field :user, Types::User, null: true

  def resolve(input:)
    user = Member.find(input.to_h[:id])
    user.tap do |u|
      u.skip_confirmation_notification!
      u.confirm
    end
    { user: user }
  end
end