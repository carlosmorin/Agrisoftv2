class ChangeNameToDeliveryAdressesToDeliveryAddressFromQuotes < ActiveRecord::Migration[6.0]
  def change
  	rename_column :quotes, :delivery_addresses_id, :delivery_address_id
  end
end
