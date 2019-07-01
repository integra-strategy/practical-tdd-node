class ChangePackageToStringForUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :package, :string
  end
end
