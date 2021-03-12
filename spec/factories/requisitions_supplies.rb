FactoryBot.define do
  factory :requisitions_supply do
    requisition { nil }
    supply { nil }
    supply { "MyString" }
  end
end
