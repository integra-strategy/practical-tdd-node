class User < ApplicationRecord
  has_one_attached :profile_picture
  has_many :dogs
  devise :database_authenticatable, :token_authenticatable, :confirmable
  validates_uniqueness_of :email, message: 'An account already exists for this email'
  validate :ten_digit_phone_number
  validate :passwords_match
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

  def to_graphql
    attributes.tap do |attributes|
      unless dogs.empty?
        attributes[:dogs] = dogs.as_json
      end
      if profile_picture.attached?
        attributes[:profile_picture] = profile_picture
      end
      unless package.nil?
        attributes[:package] = Package.fetch(package)
      end
    end
  end

  def confirmed
    !!confirmed_at
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def subscription_active?
    true
  end
  alias_method :subscription_active, :subscription_active?

  def package
    @package ||= Package.fetch(package_id)
  end
end
