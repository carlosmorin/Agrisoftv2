class CreateRequisitionsSupplies < ActiveRecord::Migration[6.0]
  def change
    create_table :requisitions_supplies do |t|
      t.references :requisition, null: false, foreign_key: true
      t.references :supply, null: false, foreign_key: true
      t.references :unit_measure, null: false, foreign_key: true
      t.string :supply
      t.integer :status
      t.decimal :quantity

      t.timestamps
    end
  end
end
