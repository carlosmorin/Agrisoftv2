class ActiveIngredientSupply < ApplicationRecord
  belongs_to :supply
  belongs_to :active_ingredient

  delegate :name, :id, to: :active_ingredient, prefix: true, allow_nil: true
end
