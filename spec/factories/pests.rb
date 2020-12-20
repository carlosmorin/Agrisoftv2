# frozen_string_literal: true

FactoryBot.define do
  factory :pest do
    name { 'MyString' }
    scientific_name { 'MyString' }
    crop { nil }
  end
end
