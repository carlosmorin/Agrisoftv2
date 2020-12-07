class AddDiscountToBillConcepts < ActiveRecord::Migration[6.0]
  def change
    add_column :bill_concepts, :discount, :float
  end
end
