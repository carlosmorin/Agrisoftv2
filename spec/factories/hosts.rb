# frozen_string_literal: true

FactoryBot.define do
  factory :host do
    name { 'MyString' }
    hostable_id { 1 }
    hostable_type { 'MyString' }
  end
end
