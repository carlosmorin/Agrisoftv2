# frozen_string_literal: true

class CreateTreatmentSupplies < ActiveRecord::Migration[6.0]
  def change
    create_table :treatment_supplies do |t|
      t.references :treatment, null: false, foreign_key: true
      t.integer :supply_id
      t.jsonb :recommended_dose

      t.timestamps
    end
    add_index :treatment_supplies, :supply_id
  end
end
