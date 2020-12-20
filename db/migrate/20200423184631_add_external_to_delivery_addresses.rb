# frozen_string_literal: true

class AddExternalToDeliveryAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :delivery_addresses, :external, :boolean
  end
end
