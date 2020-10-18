class ContractsExpense < ApplicationRecord
  belongs_to :contract
  belongs_to :expense
  belongs_to :currency
  
  validates :expense_id, presence: true
end
