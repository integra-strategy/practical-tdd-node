class AddTypeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :type, :text
  end
end
