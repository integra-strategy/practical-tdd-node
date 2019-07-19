FactoryBot.define do
  factory :dog do
    user { create(:member) }
    rabies { Time.zone.now + 1.days }
    dhlpp { Time.zone.now + 1.days }
    leptospirosis { Time.zone.now + 1.days }
    bordetella { Time.zone.now + 1.days }
    separate_leptospirosis { true }

    transient do
      vaccination_pictures { [] }
    end

    after(:create) do |dog, evaluator|
      vaccination_pictures = evaluator.vaccination_pictures
      vaccination_pictures.each do |filename|
        dog.vaccination_pictures.attach(io: File.open(Rails.root.join('spec', 'fixtures', filename)), filename: filename)
      end
    end
  end
end