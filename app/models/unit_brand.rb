class UnitBrand < ApplicationRecord
  default_scope { order(:created_at) }
	validates :name, presence: true
	has_many :units
end
