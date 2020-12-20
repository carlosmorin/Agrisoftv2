# frozen_string_literal: true

class AddDefaultPriceToShipmentsProducts < ActiveRecord::Migration[6.0]
  def change
    change_column :shipments_products, :price, :integer, default: 0
    change_column :shipments_products, :quantity, :integer, default: 0
  end
end
