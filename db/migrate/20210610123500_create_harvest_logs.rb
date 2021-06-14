class CreateHarvestLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :harvest_logs do |t|
      t.references :crop, null: false, foreign_key: true
      t.references :area, null: false, foreign_key: true
      t.references :production_unit, null: false, foreign_key: true
      t.integer :n_items
      t.references :harvest, null: false, foreign_key: true

      t.timestamps
    end
  end
end
