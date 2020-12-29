# frozen_string_literal: true

FactoryBot.define do
  factory :contracts_product do
    contract { nil }
    product { nil }
    currency { nil }
    quantity { 1 }
    price { '9.99' }
  end
end
