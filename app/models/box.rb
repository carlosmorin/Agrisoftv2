class Box < ApplicationRecord
  acts_as_paranoid
  default_scope { order(:id) }
  
  before_create :set_name
  before_update :set_name
	
  validates :plate_number, :carrier_id, :box_type_id, presence: true
  validates_uniqueness_of :plate_number, case_sensitive: false
  has_many :freights, inverse_of: :box
  has_many :shipments, inverse_of: :box

  belongs_to :carrier
  belongs_to :box_type

  def set_name
    self.name = "#{box_type.name}, PLACAS: #{plate_number}".upcase
  end
end
