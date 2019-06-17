class CreateDogs < ActiveRecord::Migration[5.2]
  def change
    create_table :dogs do |t|
      t.string :picture
      t.text :name
      t.integer :age
      t.integer :sex
      t.text :color

      t.timestamps
    end

    add_reference :dogs, :user, foreign_key: true
  end
end
