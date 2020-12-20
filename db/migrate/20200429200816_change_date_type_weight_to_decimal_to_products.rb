# frozen_string_literal: true

class ChangeDateTypeWeightToDecimalToProducts < ActiveRecord::Migration[6.0]
  def change
    change_column :products, :weight, :decimal
  end
end
