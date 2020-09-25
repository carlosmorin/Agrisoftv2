class State < ApplicationRecord
	default_scope { order(:id) }
	self.primary_key = :id
	belongs_to :country, inverse_of: :states
	
	has_many :municipalities , primary_key: :id, foreign_key: :state_id, 
		class_name: "Municipality"
  has_many :delivery_addresses, inverse_of: :state
  has_many :clients, inverse_of: :state
  has_many :states, inverse_of: :state
  has_many :carriers, inverse_of: :state
  has_many :companies, inverse_of: :state
	
  validates :name, :short_name, :country_id, presence: true
  
  
  def change_state_name
    print "UPDATEING ANME"
    update(country_id: country_id + 1)
  end

end
