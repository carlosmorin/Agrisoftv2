# frozen_string_literal: true

class AddQuotesFieldsToShipmentsProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :shipments_products, :measurement_unit, :integer
  end
end
