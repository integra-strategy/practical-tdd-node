FactoryBot.define do
  factory :dog do
    user { create(:user) }
    rabies { Time.zone.now.iso8601 }
    dhlpp { Time.zone.now.iso8601 }
    leptospirosis { Time.zone.now.iso8601 }
    bordetella { Time.zone.now.iso8601 }
    separate_leptospirosis { true }
  end
end