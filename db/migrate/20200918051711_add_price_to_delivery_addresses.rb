# frozen_string_literal: true

class AddPriceToDeliveryAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :delivery_addresses, :estimated_price, :decimal
    add_reference :delivery_addresses, :currency, null: true, foreign_key: true
  end
end
