FactoryBot.define do
  factory :stripe_plan do
    sequence :id do |n|
      n.to_s
    end
    product { create(:stripe_product).id }
    amount { 3000 }
    currency { 'usd' }
    interval { 'month' }
    name { 'Monthly' }
    description { [] }
  end

  class StripePlan
    attr_accessor :id, :product, :amount, :currency, :interval, :name, :description

    def save!
      Stripe::Plan.create(
        id: id,
        product: product,
        amount: amount,
        currency: currency,
        interval: interval,
        metadata: { display_name: name, description: description.to_json }
      )
    end
  end
end