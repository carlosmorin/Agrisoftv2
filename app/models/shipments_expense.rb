class ShipmentsExpense < ApplicationRecord
  belongs_to :shipment
  belongs_to :expense
  belongs_to :currency
  validates :unit, :amount, presence: true
  before_save :set_total

  def set_total
  	self.total
  end
end
