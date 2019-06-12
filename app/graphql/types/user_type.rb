class Types::UserType < Types::BaseObject
  description 'User type for members and employees'

  field :id, ID, null: false
  field :email, String, null: true
  field :first_name, String, null: true
  field :last_name, String, null: true
  field :authorized_users, [String], "The names of users that are authorized to take the user's dog to the park", null: true
  field :phone_number, String, "10 digit phone number for user", null: true
  field :accepts_sms, Boolean, "whether or not the user has agreed to receive SMS", null: true
  field :profile_picture, String, "a URL of the profile picture for the user", null: true
  field :address, String, null: true
  field :address2, String, null: true
  field :city, String, null: true
  field :state, String, null: true
  field :zip, String, null: true
end