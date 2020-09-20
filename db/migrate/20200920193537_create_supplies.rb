class CreateSupplies < ActiveRecord::Migration[6.0]
  def change
    create_table :supplies do |t|
      t.string :name
      t.integer :currency
      t.decimal :iva
      t.decimal :ieps
      t.references :category, null: false, foreign_key: true
      t.string :code

      t.timestamps
    end
  end
end
