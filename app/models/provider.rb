# frozen_string_literal: true

class Provider < ApplicationRecord
  default_scope { order(:created_at) }
  validates :name, :provider_category_id, :subcategory_id, presence: true

  has_rich_text :comments

  enum status: %i[active inactive]

  belongs_to :currency
  belongs_to :provider_category
  belongs_to :subcategory
  belongs_to :delivery_type
  
  has_one_attached :logo
	
	has_many :contacts, as: :contactable
	has_many :addresses, as: :addressable
	has_many :fiscals, as: :fiscalable
	has_many :bank_accounts, as: :accountable
  has_many :providers_supplies, dependent: :destroy
	
	accepts_nested_attributes_for :contacts, :allow_destroy => true
	accepts_nested_attributes_for :addresses, :allow_destroy => true
	accepts_nested_attributes_for :bank_accounts, :allow_destroy => true
	accepts_nested_attributes_for :fiscals, :allow_destroy => true
end
