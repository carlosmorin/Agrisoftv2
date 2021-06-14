FactoryBot.define do
  factory :harvest do
    harvest_at { "2021-06-10 07:28:46" }
    responsable { "MyString" }
    tractor_identifier { "MyString" }
    tractor_driver { "MyString" }
    status { 1 }
    folio { "MyString" }
  end
end
