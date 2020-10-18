class CreateClientConfigs < ActiveRecord::Migration[6.0]
  def change
    create_table :client_configs do |t|
      t.references :currency, null: false, foreign_key: true
      t.integer :pay_freight
      t.integer :client_type
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
