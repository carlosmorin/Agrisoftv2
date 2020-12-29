# frozen_string_literal: true

FactoryBot.define do
  factory :shipments_expense do
    shipment { nil }
    expense { nil }
    unit { 'MyString' }
    total { '9.99' }
  end
end
