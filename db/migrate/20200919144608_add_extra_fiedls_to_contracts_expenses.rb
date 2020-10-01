class AddExtraFiedlsToContractsExpenses < ActiveRecord::Migration[6.0]
  def change
    add_reference :contracts_expenses, :currency, null: false, foreign_key: true
    add_column :contracts_expenses, :price, :decimal
  end
end
