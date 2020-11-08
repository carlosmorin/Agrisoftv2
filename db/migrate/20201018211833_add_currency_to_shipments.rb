class AddCurrencyToShipments < ActiveRecord::Migration[6.0]
  def change
    add_reference :shipments, :currency, foreign_key: true
  	
  	Shipment.all.each do |shipment|
  		currency_code = shipment.currency.nil? ? 'mxn' : shipment.currency_code
  		currency_id = Currency.find_by_code('mxn').id
  		shipment.update(currency_id: currency_id)
  	end
  end
end
