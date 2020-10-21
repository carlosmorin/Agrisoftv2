class CreatePresentations < ActiveRecord::Migration[6.0]
  def change
    create_table :presentations do |t|
      t.string :name
      t.decimal :quantity
      t.decimal :price
      t.decimal :price_to_credit
      t.references :weight_unit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
