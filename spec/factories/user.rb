FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "user#{n}@example.com"
    end
    phone_number { "(123) 456-7890" }
    profile_picture { "https://example.com" }
    confirmed_at { DateTime.now }
  end
end