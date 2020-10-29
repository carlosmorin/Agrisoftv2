class ShipmentsExpense < ApplicationRecord
  belongs_to :shipment
  belongs_to :expense
  belongs_to :currency
  validates :unit, :amount, presence: true
  before_save :get_total

  enum type_expense: { expense_type: 0, discount_type: 1 }

  def get_total
    total = calculate_total
  end

  def calculate_total
    return amount if unit.nil?
    return total_by_package if unit == 'package' 
    return total_by_price_sale if unit == 'price_sale' 
    return total_by_pallet if unit == 'pallet' 
    0
  end

  def total_by_package
    shipment.n_products * amount
  end

  def total_by_pallet
    return 0 unless shipment.n_pallets.present?
    shipment.n_pallets * amount
  end

  def total_by_price_sale
    return get_porcent(shipment.total.to_d, amount) if percentage
    amount
  end

  def total_mxn
    return total if currency.is_mxn?
    total / exchange_rate
  end

  def total_usd
    return total if currency.is_usd?
    return total * exchange_rate
  end

  def exchange_rate
    shipment.exchange_rate
  end

  private

  def get_porcent(amount, percent)
    (amount / 100) * percent
  end
end
