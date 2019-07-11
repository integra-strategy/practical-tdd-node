class Member < User
  def subscription_active?
    subscriptions = Stripe::Customer.retrieve(stripe_id).subscriptions
    return false if subscriptions.empty?
    subscriptions.all? { |subscription| subscription.status == 'active' }
  rescue Stripe::InvalidRequestError => e
    Rails.logger.error(e.backtrace)
    false
  end
end