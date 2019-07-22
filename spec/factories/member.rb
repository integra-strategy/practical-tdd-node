FactoryBot.define do
  factory :member do
    sequence :email do |n|
      "member#{n}@example.com"
    end
    confirmed_at { DateTime.now }
    park { create(:park) }

    transient do
      unconfirmed { false }
      set_subscription_active { true }
      create_subscription { false }
    end

    before(:create) do |member, evaluator|
      if evaluator.unconfirmed
        member.skip_confirmation_notification!
        member.confirmed_at = nil
      end
    end

    after(:create) do |member, evaluator|
      if evaluator.create_subscription
        plan = create(:stripe_plan)
        token = create(:stripe_card_token)
        member.update(package_id: plan.id, stripe_card_token: token.id)
        customer = Customer.create(member)
        package = Package.fetch(member.package_id)
        Subscription.create(customer: customer, package: package)
      end
    end

    trait :with_name do
      sequence :first_name do |n|
        "John#{n}"
      end

      sequence :last_name do |n|
        "Doe#{n}"
      end
    end

    trait :with_phone_number do
      phone_number { 1234567890 }
    end
  end
end