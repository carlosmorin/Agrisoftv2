class AddWeigthUnitReferenceAndWeigthToProductionUnits < ActiveRecord::Migration[6.0]
  def change
    add_reference :production_units, :weight_unit, foreign_key: true
    add_column :production_units, :weight, :decimal
  end
end
