class CreateProvidersSupplies < ActiveRecord::Migration[6.0]
  def change
    create_table :providers_supplies do |t|
      t.references :provider, null: false, foreign_key: true
      t.references :supply, null: false, foreign_key: true

      t.timestamps
    end
  end
end
