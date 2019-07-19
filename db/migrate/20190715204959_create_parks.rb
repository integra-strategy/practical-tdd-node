class CreateParks < ActiveRecord::Migration[5.2]
  def change
    create_table :parks do |t|
      t.text :name
    end
    add_reference :users, :park, foreign_key: true
  end
end
