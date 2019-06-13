class AddStepAndCompletedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :step, :integer
    add_column :users, :completed, :boolean
  end
end
