class AddExtrafieldsToContracts < ActiveRecord::Migration[6.0]
  def change
    add_column :contracts, :undefined_products, :boolean
    add_reference :contracts, :currency, null: false, foreign_key: true
  end
end
