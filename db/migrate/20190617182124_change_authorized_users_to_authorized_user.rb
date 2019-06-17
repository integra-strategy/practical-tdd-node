class ChangeAuthorizedUsersToAuthorizedUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :authorized_users
    add_column :users, :authorized_user, :text
  end
end
