class AddTermsAndPackagesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :accepted_terms, :boolean
    add_column :users, :receives_lower_price, :boolean
    add_column :users, :package, :integer
  end
end
