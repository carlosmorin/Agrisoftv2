class ActiveIngredientSupply < ApplicationRecord
  belongs_to :supply
  belongs_to :active_ingredient
end
