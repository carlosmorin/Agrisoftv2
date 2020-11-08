class Unit < ApplicationRecord
  default_scope { order(:id) }

  before_create :set_name
  before_update :set_name
  
  validates :color, :year, :plate_number, :carrier_id, 
  	:unit_brand_id, presence: true
	validates_uniqueness_of :plate_number, case_sensitive: false
	belongs_to :unit_brand
	belongs_to :carrier
	has_one_attached :picture
	has_many :shipments, inverse_of: :unit
	has_many :remissions, inverse_of: :unit

	def set_name
		brand = 
			unit_brand.short_name.present? ? unit_brand.short_name : unit_brand.name  
		n_economic = n_econ.present? ? n_econ : '--'
		self.name = "#{brand}, #{color}, PLACAS: #{plate_number}, N° ECON: #{n_economic}".upcase
	end

	def short_name
		brand =
			unit_brand.short_name.present? ? unit_brand.short_name : unit_brand.name  
		"#{brand} #{plate_number}"
	end

end