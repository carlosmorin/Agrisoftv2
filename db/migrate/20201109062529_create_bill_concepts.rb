class CreateBillConcepts < ActiveRecord::Migration[6.0]
  def change
    create_table :bill_concepts do |t|
      t.string :description
      t.integer :quantity
      t.decimal :unit_price
      t.decimal :import
      t.references :bill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
