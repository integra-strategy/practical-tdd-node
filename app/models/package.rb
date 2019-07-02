class Package
  DAILY_DISPLAY_NAME = 'Daily'

  def self.fetch(id)
    return EmptyPackage.new if id.nil?
    new Stripe::Plan.retrieve(id)
  end

  def self.fetch_all
    packages_from_stripe = Stripe::Plan.list(limit: 10).map { |plan| new plan }
    packages_from_stripe.prepend(daily_package)
  end

  def initialize(plan)
    @plan = plan || {}
  end

  def id
    @plan[:id]
  end

  def name
    metadata[:display_name]
  end

  def amount
    @plan[:amount]
  end

  def description
    JSON.parse(metadata[:description])
  end

  private

  def metadata
    @plan[:metadata] || {}
  end

  # We have to add a static daily package because Stripe doesn't
  # support adding a pricing plan (which is what represents a package
  # in our system) for a 1 time charge.
  def self.daily_package
    new({
      id: 'daily',
      amount: 10,
      metadata: {
        display_name: DAILY_DISPLAY_NAME,
        description: [
          "Provides Full Access to Park",
          "No Commitment",
          "Fee Taken at Park",
          "Perfect for the Out of Towner"
        ].to_json
        }
      })
  end
end