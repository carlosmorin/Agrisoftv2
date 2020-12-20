# frozen_string_literal: true

class Currency < ApplicationRecord
  validates :name, :code, presence: true
  scope :national, -> { where(national: true) }
  has_many :bank_accounts, inverse_of: :currency
  has_many :delivery_addresses, inverse_of: :currency
  has_many :contracts, inverse_of: :currency
  has_many :contracts_expenses, inverse_of: :currency
  has_many :shipments_expenses, inverse_of: :currency

  def is_usd?
    code == 'usd'
  end

  def is_mxn?
    code == 'mxn'
  end
end
