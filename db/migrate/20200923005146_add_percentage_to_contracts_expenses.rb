class AddPercentageToContractsExpenses < ActiveRecord::Migration[6.0]
  def change
    add_column :contracts_expenses, :percentage, :boolean
  end
end
