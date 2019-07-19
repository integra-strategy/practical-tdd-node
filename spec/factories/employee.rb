FactoryBot.define do
  factory :employee do
    sequence :email do |n|
      "employee#{n}@example.com"
    end
    confirmed_at { DateTime.now }
    park { Park.first || create(:park) }
  end
end