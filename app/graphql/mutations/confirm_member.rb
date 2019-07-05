class Mutations::ConfirmMember < Mutations::BaseMutation
  argument :input, Types::ConfirmMember, required: true

  field :user, Types::User, null: true

  def resolve(input:)
    member = Member.find(input.to_h[:id])
    member.skip_confirmation_notification!
    member.confirm
    customer = Customer.create(member)
    package = Package.fetch(member.package)
    Subscription.create(customer: customer, package: package)
    { user: member }
  end
end