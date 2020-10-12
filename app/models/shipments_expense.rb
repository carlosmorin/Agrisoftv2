class ShipmentsExpense < ApplicationRecord
  belongs_to :shipment
  belongs_to :expense
  belongs_to :currency
  validates :unit, :amount, presence: true
  before_save :set_total

	enum type_expense: { expense_type: 0, discount_type: 1 }

  def set_total
  	self.total
  end

end
