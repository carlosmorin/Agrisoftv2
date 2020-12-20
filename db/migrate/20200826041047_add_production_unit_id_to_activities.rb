# frozen_string_literal: true

class AddProductionUnitIdToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :production_unit_id, :bigint, foreign_key: true

    add_index :activities, :production_unit_id

    remove_column :activities, :production_unit
  end
end
