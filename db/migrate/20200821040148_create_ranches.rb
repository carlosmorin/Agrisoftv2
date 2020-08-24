class CreateRanches < ActiveRecord::Migration[6.0]
  def change
    create_table :ranches do |t|
      t.string :state
      t.string :city
      t.bigint :manager_id, foreign_key: true
      t.string :territory
      t.string :hydrological_region
      t.string :aquifer_name
      t.string :georeference

      t.timestamps
    end
    add_index :ranches, :manager_id
  end
end
