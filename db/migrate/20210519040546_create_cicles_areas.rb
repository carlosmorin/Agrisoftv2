class CreateCiclesAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :cicles_areas do |t|
      t.references :cicle, null: false, foreign_key: true
      t.references :area, null: false, foreign_key: true
      t.datetime :started_at
      t.datetime :finished_at
      t.integer :status
      t.string :name
      t.float :busy_porcent

      t.timestamps
    end
  end
end
