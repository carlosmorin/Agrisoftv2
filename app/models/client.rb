# frozen_string_literal: true

class Client < ApplicationRecord
  acts_as_paranoid
  default_scope { order(:created_at) }
  validates :name, :cp, :address, :code, presence: true
  validates :country_id, :state_id, :municipality_id, :phone, :address, presence: true
  has_many :delivery_addresses, inverse_of: :client
  belongs_to :country
  belongs_to :state
  belongs_to :municipality
  has_many :client_brands, inverse_of: :client
  has_many :shipments, inverse_of: :client
  has_many :freights, as: :debtable, inverse_of: :client
  has_many :contracts, inverse_of: :client
  has_many :client_configs, inverse_of: :client
  has_many :bills, inverse_of: :client

  validates_uniqueness_of :phone, :code, case_sensitive: false
  has_many :contacts, as: :contactable
  has_many :fiscals, as: :fiscalable, validate: -> { binding.pry }
  has_many :bank_accounts, as: :accountable
  accepts_nested_attributes_for :fiscals, allow_destroy: true

  def full_address
    "#{address}, #{municipality.name}, #{state.name}, #{country.name}"
  end

  def origin_state
    state.name.to_s.upcase
  end

  def short_address
    "#{municipality.name}, #{state.name}, #{address}"
  end

  def currency
    settings.currency
  end

  def credit_days
    settings.credit_days
  end

  def settings
    return unless client_configs.any?

    client_configs.first
  end

  def national?
    settings.client_type == 'national'
  end

  def international?
    settings.client_type == 'international'
  end

  def start_date
    settings.date_due
  end

  def contract
    contracts.frst
  end

  def rfc
    return '--' unless fiscals.any?

    fiscals.first.rfc
  end

  def fiscal_name
    return '--' unless fiscals.any?

    fiscals.first.bussiness_name
  end
end
