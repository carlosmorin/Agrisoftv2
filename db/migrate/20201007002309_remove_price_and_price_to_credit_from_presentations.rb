# frozen_string_literal: true

class RemovePriceAndPriceToCreditFromPresentations < ActiveRecord::Migration[6.0]
  def change
    remove_column :presentations, :price
    remove_column :presentations, :price_to_credit
  end
end
