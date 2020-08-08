class ContractsExpense < ApplicationRecord
  belongs_to :contract
  belongs_to :expense
end
