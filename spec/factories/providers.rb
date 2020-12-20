# frozen_string_literal: true

FactoryBot.define do
  factory :provider do
    name { 'MyString' }
    business_name { 'MyString' }
    rfc { 'MyString' }
    email { 'MyString' }
    phone { 'MyString' }
    status { 1 }
  end
end
