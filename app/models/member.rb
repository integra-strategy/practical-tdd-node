class Member < User
  def subscription_active?
    Stripe::Customer.retrieve(stripe_id).subscriptions.all? { |subscription| subscription.status == 'active' }
  rescue Stripe::InvalidRequestError => e
    Rails.logger.error(e.backtrace)
    false
  end
end