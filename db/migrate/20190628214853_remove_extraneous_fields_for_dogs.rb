class RemoveExtraneousFieldsForDogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :dogs, :picture
    remove_column :dogs, :vaccination_image_urls
  end
end
