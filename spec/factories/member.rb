FactoryBot.define do
  factory :member do
    sequence :email do |n|
      "member#{n}@example.com"
    end
    confirmed_at { DateTime.now }

    transient do
      unconfirmed { true }
    end

    before(:create) do |user, evaluator|
      if evaluator.unconfirmed
        user.skip_confirmation_notification!
        user.confirmed_at = nil
      end
    end
  end
end