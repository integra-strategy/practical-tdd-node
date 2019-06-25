FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "user#{n}@example.com"
    end
    profile_picture { "https://example.com" }
    confirmed_at { DateTime.now }
  end
end