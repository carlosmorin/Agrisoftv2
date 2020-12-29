# frozen_string_literal: true

class Quote < ApplicationRecord
  belongs_to :client
  belongs_to :company
  belongs_to :contact
  belongs_to :delivery_address
  belongs_to :user
  has_rich_text :description
  has_many :shipments_products, as: :productable
  accepts_nested_attributes_for :shipments_products, allow_destroy: true

  def expirated_at
    issue_at + expirated_days.days
  end

  def subtotal
    subTotal = 0
    shipments_products.map do |product|
      subTotal += (product.quantity.to_i * product.price.to_i)
    end
    subTotal
  end

  def folio
    case id.to_s.size
    when 1
      "COT-000#{id}"
    when 2
      "COT-00#{id}"
    when 3
      "COT-0#{id}"
    when 4
      "COT-#{id}"
    end
  end
end
