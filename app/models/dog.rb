class Dog < ApplicationRecord
  has_one_attached :profile_picture
  has_many_attached :vaccination_pictures
  belongs_to :user
  enum sex: [Types::Sex::MALE, Types::Sex::FEMALE]
  include GraphQlErrors

  def attributes
    super.tap do |attrs|
      if profile_picture.attached?
        attrs[:profile_picture] = profile_picture
      end
      unless user.nil?
        attrs[:user] = user.as_json
      end
      if vaccination_pictures.attached?
        attrs[:vaccination_pictures] = vaccination_pictures
      end
    end
  end
end
