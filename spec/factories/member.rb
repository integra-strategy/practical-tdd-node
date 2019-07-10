FactoryBot.define do
  factory :member do
    sequence :email do |n|
      "member#{n}@example.com"
    end
    confirmed_at { DateTime.now }

    transient do
      unconfirmed { true }
    end

    before(:create) do |member, evaluator|
      if evaluator.unconfirmed
        member.skip_confirmation_notification!
        member.confirmed_at = nil
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