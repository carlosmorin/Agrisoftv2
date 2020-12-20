# frozen_string_literal: true

class AddPriceAndPriceToCreditToPresentationSupplies < ActiveRecord::Migration[6.0]
  def change
    add_column :presentation_supplies, :price, :decimal
    add_column :presentation_supplies, :price_to_credit, :decimal
  end
end
