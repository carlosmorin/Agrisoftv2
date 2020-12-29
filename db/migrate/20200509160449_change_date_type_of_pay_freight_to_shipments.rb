# frozen_string_literal: true

class ChangeDateTypeOfPayFreightToShipments < ActiveRecord::Migration[6.0]
  def change
    change_column :shipments, :pay_freight, 'integer USING CAST(pay_freight AS integer)'
  end
end
