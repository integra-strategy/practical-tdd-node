class User < ApplicationRecord
  has_one_attached :profile_picture
  devise :database_authenticatable, :token_authenticatable, :confirmable
  validates_uniqueness_of :email, message: 'An account already exists for this email'
  validate :ten_digit_phone_number
  validate :passwords_match
  enum package: [Types::Package::DAILY, Types::Package::MONTHLY_MANUAL, Types::Package::MONTHLY_RECURRING, Types::Package::YEARLY]
  include GraphQlErrors

  def ten_digit_phone_number
    if phone_number.present?
      formatted_phone_number = phone_number.gsub(/\D/, "")
      errors.add(:phone_number, "Phone number must be 10 digits") unless formatted_phone_number.length == 10
    end
  end

  def passwords_match
    if password_confirmation.present? && password.present? && password_confirmation != password
      errors.add(:password, "Passwords don't match")
    end
  end
end
