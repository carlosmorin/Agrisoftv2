class Expense < ApplicationRecord
  default_scope { order(:created_at) }
  validates :name, presence: true
  has_many :contracts_expenses, inverse_of: :expense
  has_many :shipments_expenses, inverse_of: :expense
  has_many :shipments_discounts, inverse_of: :expense
end
