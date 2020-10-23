FactoryBot.define do
  factory :sat_cfdi_usage, class: 'Sat::CfdiUsage' do
    descripcion { "MyString" }
    physical_person { false }
    moral_person { false }
  end
end
