# frozen_string_literal: true

class AddCreditDaysToClientConfigs < ActiveRecord::Migration[6.0]
  def change
    add_column :client_configs, :credit_days, :integer
  end
end
