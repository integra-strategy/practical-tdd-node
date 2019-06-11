class AddAcceptsSmsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :accepts_sms, :boolean
  end
end
