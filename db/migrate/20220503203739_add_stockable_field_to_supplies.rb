class AddStockableFieldToSupplies < ActiveRecord::Migration[6.0]
  def change
    add_column :supplies, :stockable, :boolean
  end
end
