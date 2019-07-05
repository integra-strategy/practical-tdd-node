FactoryBot.define do
  factory :stripe_customer do
    sequence :id do |n|
      n.to_s
    end
  end

  class StripeCustomer
    attr_accessor :id
  end
end