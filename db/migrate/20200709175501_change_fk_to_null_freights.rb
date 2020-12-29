# frozen_string_literal: true

class ChangeFkToNullFreights < ActiveRecord::Migration[6.0]
  def change
    change_column_null :freights, :carrier_id, true
    change_column_null :freights, :driver_id, true
    change_column_null :freights, :unit_id, true
    change_column_null :freights, :box_id, true
  end
end
