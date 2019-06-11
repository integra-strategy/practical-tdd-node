class Types::UserType < Types::BaseObject
  field :id, ID, null: false
  field :email, String, null: true
  field :first_name, String, null: true
  field :last_name, String, null: true
  field :authorized_users, [String], null: true
  field :phone_number, String, null: true
  field :accepts_sms, Boolean, null: true
  field :profile_picture, String, null: true
  field :address, String, null: true
  field :address2, String, null: true
  field :city, String, null: true
  field :state, String, null: true
  field :zip, String, null: true
end