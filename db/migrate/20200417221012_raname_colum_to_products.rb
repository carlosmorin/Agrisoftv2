# frozen_string_literal: true

class RanameColumToProducts < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :wieght, :weight
  end
end
