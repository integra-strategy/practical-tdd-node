class AddFieldsForBasicSignUpToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :authorized_users, :string, array: true, default: []
    add_column :users, :phone_number, :string
    add_column :users, :profile_picture, :string
    add_column :users, :address, :string
    add_column :users, :address2, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip, :string
  end
end
