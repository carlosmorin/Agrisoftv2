class Box < ApplicationRecord
  acts_as_paranoid
  default_scope { order(:id) }
	validates :plate_number, :carrier_id, :box_type_id, presence: true
	validates_uniqueness_of :plate_number, case_sensitive: false
	has_many :shipments, inverse_of: :box
	has_many :remissions, inverse_of: :box

  belongs_to :carrier
  belongs_to :box_type

  def full_name
  	"#{box_type.name}-#{plate_number}"
  end
end
