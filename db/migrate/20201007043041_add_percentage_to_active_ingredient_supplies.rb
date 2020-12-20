# frozen_string_literal: true

class AddPercentageToActiveIngredientSupplies < ActiveRecord::Migration[6.0]
  def change
    add_column :active_ingredient_supplies, :percentage, :decimal
  end
end
