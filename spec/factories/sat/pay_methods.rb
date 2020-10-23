FactoryBot.define do
  factory :sat_pay_method, class: 'Sat::PayMethod' do
    code { "MyString" }
    description { "MyString" }
  end
end
