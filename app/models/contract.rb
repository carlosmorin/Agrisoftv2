# frozen_string_literal: true

class Contract < ApplicationRecord
  belongs_to :client
  belongs_to :delivery_address
  has_many :contracts_products, inverse_of: :contract, dependent: :destroy
  has_many :contracts_expenses, inverse_of: :contract, dependent: :destroy
  has_many :expenses, through: :contracts_expenses, dependent: :destroy
  has_many :shipments

  accepts_nested_attributes_for :contracts_products, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :contracts_expenses, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :name, :delivery_address_id
  validates_presence_of :started_at, :finished_at, unless: :undefined

  scope :current, -> { where("CURRENT_TIMESTAMP < finished_at OR undefined_products::text = 'true'") }
  scope :overdue, -> { where('CURRENT_TIMESTAMP > finished_at') }

  def validate!
    errors.add(:name, :blank, message: 'cannot be nil') if name.nil?
  end

  def active?
    return true if undefined?

    Time.now <= finished_at
  end

  def currency
    national = Currency.national.first
    return national if contracts_products.empty?

    contracts_products.first.currency
  end
end
