# frozen_string_literal: true

class AddDateDueToClientConfigs < ActiveRecord::Migration[6.0]
  def change
    add_column :client_configs, :date_due, :integer
  end
end
