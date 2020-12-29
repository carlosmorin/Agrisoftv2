# frozen_string_literal: true

FactoryBot.define do
  factory :subcategory do
    name { 'MyString' }
    description { 'MyText' }
    subcategoritable { nil }
  end
end
