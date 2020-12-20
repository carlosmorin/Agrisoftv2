# frozen_string_literal: true

class AddUnitSaleFieldToContractsExpenses < ActiveRecord::Migration[6.0]
  def change
    add_column :contracts_expenses, :unit_sale, :string
  end
end
