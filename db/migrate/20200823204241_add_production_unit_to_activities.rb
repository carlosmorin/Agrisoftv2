# frozen_string_literal: true

class AddProductionUnitToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :production_unit, :string
  end
end
