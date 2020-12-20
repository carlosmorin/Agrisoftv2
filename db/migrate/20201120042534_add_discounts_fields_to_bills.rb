# frozen_string_literal: true

class AddDiscountsFieldsToBills < ActiveRecord::Migration[6.0]
  def change
    add_column :bills, :discount, :float
    add_column :bills, :expenses, :float
    add_reference :bills, :fiscal, foreign_key: true
  end
end
