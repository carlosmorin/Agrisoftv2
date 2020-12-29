# frozen_string_literal: true

class AddOrderSaleToShipments < ActiveRecord::Migration[6.0]
  def change
    add_column :shipments, :order_sale_folio, :string
  end
end
