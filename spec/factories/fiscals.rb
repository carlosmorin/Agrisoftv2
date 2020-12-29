# frozen_string_literal: true

FactoryBot.define do
  factory :fiscal do
    bussiness_name { 'MyString' }
    rfc { 'MyString' }
    fiscalable { nil }
  end
end
