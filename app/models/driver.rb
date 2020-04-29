class Driver < ApplicationRecord
  acts_as_paranoid
  before_create :set_name
  before_update :set_name

	default_scope { order(:id) }
  belongs_to :carrier, inverse_of: :drivers
  validates :name, :last_name, :phone, :licence, :carrier_id, presence: true
  has_many_attached :licence_imgs
	has_many :shipments, inverse_of: :driver
	validates_uniqueness_of :licence, :phone, case_sensitive: false

  def set_name
    self.full_name = "#{name} #{last_name}".upcase
  end
end
