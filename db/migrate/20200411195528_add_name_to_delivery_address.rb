# frozen_string_literal: true

class AddNameToDeliveryAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :delivery_addresses, :name, :string
  end
end
