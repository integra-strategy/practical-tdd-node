FactoryBot.define do
  factory :user do
    phone_number { "(123) 456-7890" }
    profile_picture { "https://example.com" }
  end
end