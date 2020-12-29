# frozen_string_literal: true

class RenameFkToShipments < ActiveRecord::Migration[6.0]
  def change
    rename_column :shipments, :shipment_id, :freight_id
  end
end
