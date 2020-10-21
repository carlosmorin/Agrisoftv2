class CreateActiveIngredientSupplies < ActiveRecord::Migration[6.0]
  def change
    create_table :active_ingredient_supplies do |t|
      t.references :supply, null: false, foreign_key: true
      t.references :active_ingredient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
