class RenameTableRemissionsProductsToShipmentsProducts < ActiveRecord::Migration[6.0]
  def change
	  rename_table :remissions_products, :shipments_products
  	rename_column :shipments_products, :remission_id, :shipment_id
  end
end
