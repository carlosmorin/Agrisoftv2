FactoryBot.define do
  factory :contract do
    name { "MyString" }
    client { nil }
    started_at { "2020-08-04 12:50:41" }
    finished_at { "2020-08-04 12:50:41" }
    delivery_address { nil }
  end
end
