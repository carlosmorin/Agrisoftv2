# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id { 1 }
    email { 'admin@lasalbardas.com' }
    password { '123456' }
    name { 'José Carlos' }
    last_name { 'Morin Riojas' }
  end
end
