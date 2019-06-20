class User < ApplicationRecord
  devise :database_authenticatable, :token_authenticatable, :confirmable
  validates_uniqueness_of :email, message: 'An account already exists for this email'
  validate :ten_digit_phone_number
  validate :profile_picture_url_valid
  validate :passwords_match
  enum package: [Types::Package::DAILY, Types::Package::MONTHLY_MANUAL, Types::Package::MONTHLY_RECURRING, Types::Package::YEARLY]
  include GraphQlErrors

  def ten_digit_phone_number
    if phone_number.present?
      formatted_phone_number = phone_number.gsub(/\D/, "")
      errors.add(:phone_number, "Phone number must be 10 digits") unless formatted_phone_number.length == 10
    end
  end

  def profile_picture_url_valid
    if profile_picture.present? && !URI::regexp(%w(http https)).match?(profile_picture)
      errors.add(:profile_picture, "Profile picture must be a valid URL")
    end
  end

  def passwords_match
    if password_confirmation.present? && password.present? && password_confirmation != password
      errors.add(:password, "Passwords don't match")
    end
  end
end
