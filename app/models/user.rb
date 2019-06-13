class User < ApplicationRecord
  devise :database_authenticatable, :token_authenticatable
  validates_uniqueness_of :email, message: 'An account already exists for this email'
  validate :phone_number_must_be_10_digits
  validate :profile_picture_must_be_valid_url

  def phone_number_must_be_10_digits
    if phone_number.present?
      formatted_phone_number = phone_number.gsub(/\D/, '')
      errors.add(:phone_number, "Phone number must be 10 digits") unless formatted_phone_number.length == 10
    end
  end

  def profile_picture_must_be_valid_url
    if profile_picture.present? && !URI::regexp(%w(http https)).match?(profile_picture)
      errors.add(:profile_picture, 'Profile picture must be a valid URL')
    end
  end
end
