class Driver < ApplicationRecord
  acts_as_paranoid
	default_scope { order(:id) }
  belongs_to :carrier, inverse_of: :drivers
  validates :name, :last_name, :phone, :licence, :carrier_id, presence: true
  has_many_attached :licence_imgs

  def full_name
  	"#{name} #{last_name}".upcase
  end
end
