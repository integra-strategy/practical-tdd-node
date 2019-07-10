class RenameTokenToStripeCardToken < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :token, :stripe_card_token
  end
end
