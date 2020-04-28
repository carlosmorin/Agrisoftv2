class CreateRemissions < ActiveRecord::Migration[6.0]
  def change
    create_table :remissions do |t|
      t.references :company, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.references :carrier, null: false, foreign_key: true
      t.references :unit, null: false, foreign_key: true
      t.references :box, null: false, foreign_key: true
      t.references :delivery_address, null: false, foreign_key: true
      t.references :user
      t.boolean :pay_freight
      t.text :comments
      
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
