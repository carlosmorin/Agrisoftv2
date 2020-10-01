class ShipmentsProductReport < ApplicationRecord
  belongs_to :shipments_product
  belongs_to :currency
  validates :quantity, :price, presence: true
end
