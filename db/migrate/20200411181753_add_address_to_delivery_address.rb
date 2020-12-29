# frozen_string_literal: true

class AddAddressToDeliveryAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :delivery_addresses, :address, :string
  end
end
