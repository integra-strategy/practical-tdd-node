FactoryBot.define do
  factory :stripe_product do
    sequence :id do |n|
      n.to_s
    end
    type { 'service' }
    name { 'Park Membership' }
  end

  class StripeProduct
    attr_accessor :id, :type, :name

    def save!
      Stripe::Product.create(id: id, type: type, name: name)
    end
  end
end