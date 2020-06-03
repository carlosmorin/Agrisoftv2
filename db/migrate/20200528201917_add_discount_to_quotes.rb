class AddDiscountToQuotes < ActiveRecord::Migration[6.0]
  def change
    add_column :quotes, :discount, :decimal
  end
end
