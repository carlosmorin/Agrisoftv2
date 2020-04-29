class Freight < ApplicationRecord
	before_create :set_folio
	validates :carrier_id, :driver_id, :unit_id, :box_id, presence: true
	belongs_to :carrier
	belongs_to :driver
	belongs_to :unit
	belongs_to :box
	belongs_to :user
	has_many :shipments, inverse_of: :freight
	accepts_nested_attributes_for :shipments, allow_destroy: true

	private

	def set_folio
		year = Time.now.year
		total_freight = get_total_freight(year.to_s)
		year =  year.to_s[2, 2]
		self.folio = "FF-#{year}-#{total_freight}"
	end

	def get_total_freight(year)
		total_freight = Freight.where('extract(year from created_at) = ?', year).size
		case total_freight.to_s.size
		when 1
			"000#{total_freight.to_i + 1 }"
		when 2
		  "00#{total_freight.to_i + 1 }"
		when 3	
			"0#{total_freight.to_i + 1 }"
		when 4
			"#{total_freight.to_i + 1 }"
		end
	end
end