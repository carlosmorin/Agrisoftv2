# frozen_string_literal: true

class Fiscal < ApplicationRecord
  belongs_to :fiscalable, polymorphic: true
  has_many :addresses, as: :addressable
  has_many :bills, inverse_of: :fiscal
  accepts_nested_attributes_for :addresses, allow_destroy: true
  validates :bussiness_name, :rfc, presence: true
  validates :cfdi_usage, :payment_mean, :payment_method,
            presence: true, if: proc { fiscalable.try(:fiscal?) }
  validates :external_vat, presence: true, if: proc { country_valid? }

  def address
    addresses.first
  end

  def locality
    address.locality
  end

  private

  def country_valid?
    (fiscalable.try(:fiscal?) && fiscalable&.country&.short_name.eql?('USA'))
  end
end
