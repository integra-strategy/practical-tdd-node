class Dog < ApplicationRecord
  has_one_attached :picture
  belongs_to :user
  enum sex: [Types::Sex::MALE, Types::Sex::FEMALE]
  include GraphQlErrors

  def attributes
    super.tap do |attrs|
      if picture.attached?
        attrs[:picture] = Rails.application.routes.url_helpers.rails_blob_path(picture, only_path: true)
      end
      unless user.nil?
        attrs[:user] = user.as_json
      end
    end
  end
end
