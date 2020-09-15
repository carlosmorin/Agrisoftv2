class AddShipmentsAtToShipments < ActiveRecord::Migration[6.0]
  def change
    add_column :shipments, :shipment_at, :datetime
  end
end
