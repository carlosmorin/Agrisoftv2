# frozen_string_literal: true

class AddTotalsFieldsToBills < ActiveRecord::Migration[6.0]
  def change
    add_column :bills, :iva, :integer, default: 0
    add_column :bills, :subtotal, :decimal, default: 0
    add_column :bills, :total, :decimal, default: 0
  end
end
