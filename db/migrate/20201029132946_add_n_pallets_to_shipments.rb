# frozen_string_literal: true

class AddNPalletsToShipments < ActiveRecord::Migration[6.0]
  def change
    add_column :shipments, :n_pallets, :integer, default: 0
  end
end
