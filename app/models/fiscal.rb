# frozen_string_literal: true

class Fiscal < ApplicationRecord
  belongs_to :fiscalable, polymorphic: true
  has_many :addresses, as: :addressable
  has_many :bills, inverse_of: :fiscal
  accepts_nested_attributes_for :addresses, allow_destroy: true
  validates :bussiness_name, :rfc, presence: true

  def address
    addresses.first
  end

  def locality
    address.locality
  end
end
