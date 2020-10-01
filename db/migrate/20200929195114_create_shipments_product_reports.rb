class CreateShipmentsProductReports < ActiveRecord::Migration[6.0]
  def change
    create_table :shipments_product_reports do |t|
      t.references :shipments_product, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :price
      t.references :currency, null: false, foreign_key: true

      t.timestamps
    end
  end
end
