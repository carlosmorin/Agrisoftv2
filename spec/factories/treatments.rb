# frozen_string_literal: true

FactoryBot.define do
  factory :treatment do
    treatable_id { 1 }
    treatable_type { 'MyString' }
    supplies { '' }
  end
end
