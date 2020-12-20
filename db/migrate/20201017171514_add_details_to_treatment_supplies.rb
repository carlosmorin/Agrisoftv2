# frozen_string_literal: true

class AddDetailsToTreatmentSupplies < ActiveRecord::Migration[6.0]
  def change
    remove_column :treatment_supplies, :recommended_dose, :jsonb
    add_column :treatment_supplies, :foliar_quantity, :decimal
    add_column :treatment_supplies, :foliar_unit, :string
    add_column :treatment_supplies, :irrigation_quantity, :decimal
    add_column :treatment_supplies, :irrigation_unit, :string
  end
end
