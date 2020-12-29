# frozen_string_literal: true

class ContractsProduct < ApplicationRecord
  belongs_to :contract, optional: true
  belongs_to :product, optional: true
  belongs_to :currency, optional: true

  validates :product_id, :contract_id, :currency_id, :quantity, :price, presence: true
end
