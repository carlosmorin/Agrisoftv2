# frozen_string_literal: true

class ShipmentsProductReport < ApplicationRecord
  belongs_to :shipments_product
  belongs_to :currency
  validates :quantity, :price, presence: true
  has_one_attached :voucher

  def sale
    shipments_product.shipment
  end

  def reported_at
    report_at.present? ? report_at : created_at
  end
end
