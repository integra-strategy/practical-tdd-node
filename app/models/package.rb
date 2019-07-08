class Package
  DAILY_DISPLAY_NAME = 'Daily'

  def self.fetch(id)
    return EmptyPackage.new if id.nil?
    new Stripe::Plan.retrieve(id)
  end

  def self.fetch_all
    Stripe::Plan.list(limit: 10).map { |plan| new plan }
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

  def one_time_payment_type?
    ['Daily', 'Month-to-Month'].include?(name)
  end

  private

  def metadata
    @plan[:metadata] || {}
  end
end