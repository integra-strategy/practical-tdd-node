FactoryBot.define do
  factory :park do
    sequence(:name) do |n|
      "Park #{n}"
    end
  end
end