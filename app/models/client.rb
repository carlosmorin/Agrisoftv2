class Client < ApplicationRecord
  acts_as_paranoid
  default_scope { order(:created_at) }
  validates :name, :rfc, :country, :state, :cp, :address, presence: true
  has_many :delivery_addresses, inverse_of: :client
end