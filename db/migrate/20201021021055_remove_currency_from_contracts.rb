# frozen_string_literal: true

class RemoveCurrencyFromContracts < ActiveRecord::Migration[6.0]
  def change
    remove_column :contracts, :currency_id
  end
end
