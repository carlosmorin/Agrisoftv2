class SetShipmentAtDateFromShipments < ActiveRecord::Migration[6.0]
  def change
		shipments = Shipment.where(shipment_at: nil)
		shipments.each do |shipment|
			shipment.update(shipment_at: shipment.created_at)
		end
  end
end
