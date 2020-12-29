# frozen_string_literal: true

class AddPrebillExpenseToShipmentsExpenses < ActiveRecord::Migration[6.0]
  def change
    add_column :shipments_expenses, :prebill_expense, :boolean
  end
end
