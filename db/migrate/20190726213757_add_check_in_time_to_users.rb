class AddCheckInTimeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :check_in_time, :datetime
  end
end
