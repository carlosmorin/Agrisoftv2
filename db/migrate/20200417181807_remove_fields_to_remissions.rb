class RemoveFieldsToRemissions < ActiveRecord::Migration[6.0]
  def change
  	remove_column :remissions, :carrier_id
  	remove_column :remissions, :unit_id
  	remove_column :remissions, :box_id
  end
end
