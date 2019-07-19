class AddPositionsAndHireDateToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :positions, :string, array: true, default: []
    add_column :users, :hire_date, :datetime
  end
end
