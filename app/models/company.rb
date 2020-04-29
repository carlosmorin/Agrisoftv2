class Company < ApplicationRecord
  acts_as_paranoid
  default_scope { order(:created_at) }
  validates :name, :rfc, :country_id, :state_id, :municipality_id,
		:cp, :address, :phone, presence: true
  belongs_to :country
  belongs_to :state
  belongs_to :municipality
  has_many :remissions, inverse_of: :company

  def full_address
		"#{municipality.name}, #{state.name}, #{address}, #{country.name}"
	end
end