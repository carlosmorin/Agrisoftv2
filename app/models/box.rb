class Box < ApplicationRecord
  acts_as_paranoid
  default_scope { order(:id) }
	validates :plate_number, :carrier_id, :box_type_id, presence: true
	validates_uniqueness_of :plate_number, case_sensitive: false

  belongs_to :carrier
  belongs_to :box_type
end
