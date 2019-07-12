class Member < User
  def subscription_active?
    subscriptions = Stripe::Customer.retrieve(stripe_id).subscriptions
    return false if subscriptions.empty?
    subscriptions.all? { |subscription| subscription.status == 'active' }
  rescue Stripe::InvalidRequestError => e
    Rails.logger.error(e.backtrace)
    false
  end

  def dogs_vaccinations_current?
    dogs.all? do |dog|
      dog.rabies > Time.zone.now &&
      dog.dhlpp > Time.zone.now &&
      dog.leptospirosis > Time.zone.now &&
      dog.bordetella > Time.zone.now
    end
  end
end