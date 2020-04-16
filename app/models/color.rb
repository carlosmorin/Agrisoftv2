class Color < ApplicationRecord
  validates :name, presence: true

	has_many :crops_colors
  has_many :crops, through: :crops_colors
end
