# frozen_string_literal: true

FactoryBot.define do
  factory :bill do
    sat_cfdi_usage { 'MyString' }
    sat_pay_method { 'MyString' }
    sat_ways_pay { 'MyString' }
    company { nil }
    credit_days { 1 }
    comments { 'MyText' }
  end
end
