# frozen_string_literal: true

class ActiveIngredient < ApplicationRecord
  has_many :active_ingredient_supplies
  has_many :supplies, through: :active_ingredient_supplies

  validates :name, uniqueness: true, presence: true

  accepts_nested_attributes_for :active_ingredient_supplies
end
