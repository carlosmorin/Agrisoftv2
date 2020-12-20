# frozen_string_literal: true

class AddCurrencyToShipments < ActiveRecord::Migration[6.0]
  def change
    add_reference :shipments, :currency, foreign_key: true

    Shipment.all.each do |shipment|
      currency_code = shipment.currency.nil? ? 'MXN' : shipment.currency_code
      currency_id = Currency.find_by_code('MXN').id
      shipment.update(currency_id: currency_id)
    end
  end
end
