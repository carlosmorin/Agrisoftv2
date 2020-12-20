# frozen_string_literal: true

class CreateContractsExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :contracts_expenses do |t|
      t.references :contract, null: false, foreign_key: true
      t.references :expense, null: false, foreign_key: true

      t.timestamps
    end
  end
end
