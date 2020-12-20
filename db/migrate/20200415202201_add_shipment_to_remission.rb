# frozen_string_literal: true

class AddShipmentToRemission < ActiveRecord::Migration[6.0]
  def change
    add_reference :remissions, :shipment, null: false, foreign_key: true
  end
end
