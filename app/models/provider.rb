class Provider < ApplicationRecord
  belongs_to :currency
  belongs_to :provider_category
  belongs_to :subcategory
  belongs_to :delivery_type
  
  has_one_attached :logo
	
	has_many :contacts, as: :contactable
	has_many :addresses, as: :addressable
	has_many :fiscals, as: :fiscalable
	has_many :bank_accounts, as: :accountable
	
	accepts_nested_attributes_for :contacts, :allow_destroy => true
	accepts_nested_attributes_for :addresses, :allow_destroy => true
	accepts_nested_attributes_for :bank_accounts, :allow_destroy => true
	accepts_nested_attributes_for :fiscals, :allow_destroy => true

end
