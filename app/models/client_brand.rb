# frozen_string_literal: true

class ClientBrand < ApplicationRecord
  belongs_to :client, optional: true
  validates :name, presence: true
  has_many :products, inverse_of: :client_brand
end
