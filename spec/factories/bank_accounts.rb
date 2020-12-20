# frozen_string_literal: true

FactoryBot.define do
  factory :bank_account do
    bank { nil }
    currency { nil }
    titular { 'MyString' }
    bank_key { 'MyString' }
    account_number { 'MyString' }
    card_number { 'MyString' }
    branch { 'MyString' }
    accountable { nil }
  end
end
