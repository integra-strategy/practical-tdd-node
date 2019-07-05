class Customer < SimpleDelegator
  def self.create(member)
    customer = Stripe::Customer.create(email: member.email, name: member.full_name, source: member.stripe_card_token)
    member.update(stripe_id: customer.id)
    new(customer)
  end
end