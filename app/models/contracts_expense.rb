# frozen_string_literal: true

class ContractsExpense < ApplicationRecord
  belongs_to :contract
  belongs_to :expense
  belongs_to :currency, optional: true

  validates :expense_id, presence: true
end
