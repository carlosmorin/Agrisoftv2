FactoryBot.define do
  factory :client_config do
    currency { nil }
    pay_freight { 1 }
    client_type { 1 }
    client { nil }
  end
end
