FactoryBot.define do
  factory :dog do
    user { create(:user) }
  end
end