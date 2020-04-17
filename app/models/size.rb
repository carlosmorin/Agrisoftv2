class Size < ApplicationRecord
	acts_as_paranoid
  default_scope { order(:created_at) }
  validates :name, presence: true

  has_many :crops_sizes, inverse_of: :size
  has_many :crops, through: :crops_sizes, inverse_of: :size
  has_many :products, inverse_of: :size
end
