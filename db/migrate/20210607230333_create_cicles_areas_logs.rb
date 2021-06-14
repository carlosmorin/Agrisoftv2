class CreateCiclesAreasLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :cicles_areas_logs do |t|
      t.references :cicles_area, null: false, foreign_key: true
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
