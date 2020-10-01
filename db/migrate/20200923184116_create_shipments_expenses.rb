class CreateShipmentsExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :shipments_expenses do |t|
      t.references :shipment, null: false, foreign_key: true
      t.references :currency, null: false, foreign_key: true
      t.references :expense, null: false, foreign_key: true
      t.string :unit
      t.decimal :total
      t.decimal :amount
      t.boolean :percentage
      t.integer :type_expense

      t.timestamps
    end
  end
end
