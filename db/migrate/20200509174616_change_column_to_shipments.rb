# frozen_string_literal: true

class ChangeColumnToShipments < ActiveRecord::Migration[6.0]
  def change
    rename_column :freights, :pay_client, :pay_freight
    change_column :freights, :pay_freight, 'integer USING CAST(pay_freight AS integer)'
  end
end
