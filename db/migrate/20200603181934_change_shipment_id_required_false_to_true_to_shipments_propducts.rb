class ChangeShipmentIdRequiredFalseToTrueToShipmentsPropducts < ActiveRecord::Migration[6.0]
  def change
  	change_column :shipments_products, :shipment_id, :bigint, :null => true
  end
end
