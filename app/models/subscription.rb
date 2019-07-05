class Subscription < SimpleDelegator
  include GraphQlErrors

  def initialize(delegate)
    @errors = []
    super(delegate)
  end

  def self.create(customer:, package:)
    new Stripe::Subscription.create({
      customer: customer.id,
      items: [
        {
          plan: package.id,
        },
      ],
    })
  rescue Stripe::CardError => e
    new(InvalidStripeSubscription.new).tap do |s|
      s.add_error(:card, e.message)
    end
  end

  def add_error(path, message)
    @errors << [path, message]
  end

  def errors
    @errors
  end

  class InvalidStripeSubscription; end;
end