class DeliveryAddress < ApplicationRecord
  acts_as_paranoid
  default_scope { order(:created_at) }
  validates :name, :client_id, :country_id, :state_id, :municipality_id, 
  	:address, presence: true

  belongs_to :client
  belongs_to :country
  belongs_to :state
  belongs_to :municipality

	has_many :remissions, inverse_of: :delivery_address
end
