class RemoveGrandfatheredAttribute < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :receives_lower_price
  end
end
