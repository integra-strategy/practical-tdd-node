class Types::UserType < Types::BaseObject
  field :id, ID, null: false
  field :email, String, null: false
  field :first_name, String, null: false
  field :last_name, String, null: false
  field :authorized_users, [String], null: true
  field :profile_picture, String, null: true
  field :address, String, null: true
  field :address2, String, null: true
  field :city, String, null: true
  field :state, String, null: true
  field :zip, String, null: true
end