class RenamePackageToPackageIdOnUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :package, :package_id
  end
end
