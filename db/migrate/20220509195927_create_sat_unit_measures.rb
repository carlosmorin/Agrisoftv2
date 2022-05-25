class CreateSatUnitMeasures < ActiveRecord::Migration[6.0]
  def change
    create_table :sat_unit_measures do |t|
      t.string :key
      t.string :name

      t.timestamps
    end
  end
end
