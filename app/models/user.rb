class User < ApplicationRecord
  devise :database_authenticatable, :token_authenticatable
  validates_uniqueness_of :email, message: 'An account already exists for this email'
  validate :phone_number_must_be_10_digits
  validates_format_of :profile_picture, :with => URI::regexp(%w(http https)), message: 'Profile picture must be a valid URL'

  def phone_number_must_be_10_digits
    if phone_number.present?
      formatted_phone_number = phone_number.gsub(/\D/, '')
      errors.add(:phone_number, "Phone number must be 10 digits") unless formatted_phone_number.length == 10
    end
  end
end
