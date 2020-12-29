# frozen_string_literal: true

class ChangeCurrencyFromContracts < ActiveRecord::Migration[6.0]
  def change
    change_column :contracts_expenses, :currency_id, :integer, null: true
  end
end
