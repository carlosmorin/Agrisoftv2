FactoryBot.define do
  factory :address do
    name { "MyText" }
    street { "MyString" }
    outdoor_number { "MyString" }
    interior_number { "MyString" }
    cp { "MyString" }
    references { "MyString" }
    country { nil }
    state { nil }
    locality { nil }
    comments { "MyText" }
    type { 1 }
    type { 1 }
    addressable { nil }
  end
end
