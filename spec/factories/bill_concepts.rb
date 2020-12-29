# frozen_string_literal: true

FactoryBot.define do
  factory :bill_concept do
    description { 'MyString' }
    quantity { 1 }
    unit_price { '9.99' }
    import { '9.99' }
    bill { nil }
  end
end
