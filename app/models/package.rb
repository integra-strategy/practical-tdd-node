class Package
  def self.fetch(id)
    return EmptyPackage.new if id.nil?
    new Stripe::Plan.retrieve(id)
  end

  def initialize(plan)
    @plan = plan || {}
  end

  def id
    @plan[:id]
  end

  def name
    @plan[:metadata].try(:display_name)
  end
end