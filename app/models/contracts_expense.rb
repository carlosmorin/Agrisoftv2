class ContractsExpense < ApplicationRecord
  belongs_to :contract
  belongs_to :expense
  
  validates :expense_id, presence: true
end
