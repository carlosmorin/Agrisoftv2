class Unit < ApplicationRecord
  default_scope { order(:id) }
  validates :model, :color, :year, :plate_number, :carrier_id, 
  	:unit_brand_id, presence: true
	validates_uniqueness_of :plate_number, case_sensitive: false
	belongs_to :unit_brand
	belongs_to :carrier
	has_one_attached :picture

end