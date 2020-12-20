# frozen_string_literal: true

FactoryBot.define do
  factory :shipments_product_report do
    shipments_product { nil }
    quantity { 1 }
    price { '9.99' }
    currency { nil }
  end
end
