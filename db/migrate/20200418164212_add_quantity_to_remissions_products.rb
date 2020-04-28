class AddQuantityToRemissionsProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :remissions_products, :quantity, :integer
  end
end
