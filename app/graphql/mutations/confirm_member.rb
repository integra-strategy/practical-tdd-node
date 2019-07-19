class Mutations::ConfirmMember < Mutations::BaseMutation
  argument :input, Inputs::ConfirmMember, required: true

  field :user, Types::User, null: true
  field :errors, [Types::UserError], null: false

  def resolve(input:)
    member = Member.find(input.to_h[:id])
    member.skip_confirmation_notification!
    member.confirm
    customer = Customer.create(member)
    package = Package.fetch(member.package_id)
    subscription = Subscription.create(customer: customer, package: package)
    { user: member, errors: subscription.graphql_errors }
  end
end