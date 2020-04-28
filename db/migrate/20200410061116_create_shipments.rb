class CreateShipments < ActiveRecord::Migration[6.0]
  def change
    create_table :shipments do |t|
      t.references :carrier, null: false, foreign_key: true
      t.references :driver, null: false, foreign_key: true
      t.references :unit, null: false, foreign_key: true
      t.references :box, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :status
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
