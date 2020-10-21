FactoryBot.define do
  factory :supply do
    name { "MyString" }
    currency { 1 }
    iva { "9.99" }
    ieps { "9.99" }
    category { nil }
    code { "MyString" }
  end
end
