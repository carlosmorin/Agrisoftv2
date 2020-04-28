class Color < ApplicationRecord
  validates :name, presence: true

	has_many :crops_colors, inverse_of: :color
  has_many :crops, through: :crops_colors, inverse_of: :color
  has_many :products, inverse_of: :color
end
