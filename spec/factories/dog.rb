FactoryBot.define do
  factory :dog do
    user { create(:member) }
    rabies { Time.zone.now + 1.days }
    dhlpp { Time.zone.now + 1.days }
    leptospirosis { Time.zone.now + 1.days }
    bordetella { Time.zone.now + 1.days }
    separate_leptospirosis { true }
  end
end