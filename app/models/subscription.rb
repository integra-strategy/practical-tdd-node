class Subscription < SimpleDelegator
  def self.create(customer:, package:)
    new Stripe::Subscription.create({
      customer: customer.id,
      items: [
        {
          plan: package.id,
        },
      ],
    })
  end
end