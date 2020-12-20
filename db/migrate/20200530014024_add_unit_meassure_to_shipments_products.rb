# frozen_string_literal: true

class AddUnitMeassureToShipmentsProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :shipments_products, :unit_meassure, :integer
  end
end
