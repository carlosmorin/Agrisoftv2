# frozen_string_literal: true

FactoryBot.define do
  factory :currency do
    name { 'MyString' }
    code { 'MyString' }
    national { false }
  end
end
