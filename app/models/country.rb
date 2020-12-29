# frozen_string_literal: true

class Country < ApplicationRecord
  default_scope { order(:id) }

  has_many :states, inverse_of: :country
  has_many :delivery_addresses, inverse_of: :country
  has_many :clients, inverse_of: :country
  has_many :carriers, inverse_of: :country
  has_many :companies, inverse_of: :country

  validates :name, :short_name, presence: true
  validates_uniqueness_of :name, :short_name, case_sensitive: false
end
