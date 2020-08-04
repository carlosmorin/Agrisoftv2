class Address < ApplicationRecord
  belongs_to :country
  belongs_to :state
  belongs_to :addressable, polymorphic: true
  validates :name, :cp, :street, :neighborhood, :outdoor_number, 
  	:country_id, :state_id, :status, presence: true
  enum status: [:fiscal, :sucursal]
end
