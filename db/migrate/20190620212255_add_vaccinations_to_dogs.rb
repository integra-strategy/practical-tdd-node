class AddVaccinationsToDogs < ActiveRecord::Migration[5.2]
  def change
    add_column :dogs, :rabies, :datetime
    add_column :dogs, :dhlpp, :datetime
    add_column :dogs, :leptospirosis, :datetime
    add_column :dogs, :bordetella, :datetime
    add_column :dogs, :separate_leptospirosis, :boolean
    add_column :dogs, :vaccination_image_urls, :string, array: true, default: []
  end
end
