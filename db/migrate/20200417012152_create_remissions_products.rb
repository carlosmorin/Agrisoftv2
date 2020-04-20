class CreateRemissionsProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :remissions_products do |t|
      t.references :remission, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
