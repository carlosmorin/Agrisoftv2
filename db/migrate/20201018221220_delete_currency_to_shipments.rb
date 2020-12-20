# frozen_string_literal: true

class DeleteCurrencyToShipments < ActiveRecord::Migration[6.0]
  def change
    remove_column :shipments, :currency
  end
end
