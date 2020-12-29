# frozen_string_literal: true

class ProviderCategory < ApplicationRecord
  validates :name, presence: true
  has_many :providers, inverse_of: :provider_category
  has_many :subcategories, as: :categorytable

  has_one_attached :logo
  
  accepts_nested_attributes_for :subcategories, allow_destroy: true
end
