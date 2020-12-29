# frozen_string_literal: true

FactoryBot.define do
  factory :presentation do
    name { 'MyString' }
    quantity { '9.99' }
    price { '9.99' }
    price_to_credit { '9.99' }
    weight_unit { nil }
  end
end
