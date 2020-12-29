FactoryBot.define do
  factory :provider do
    code { "MyString" }
    name { "MyString" }
    provider_type { "MyString" }
    credit_limit { "9.99" }
    credit_limit_days { 1 }
    delivery_days { 1 }
    currency { nil }
    provider_category { nil }
    subcategory { nil }
    delivery_type { nil }
  end
end
