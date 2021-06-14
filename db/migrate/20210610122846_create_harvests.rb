class CreateHarvests < ActiveRecord::Migration[6.0]
  def change
    create_table :harvests do |t|
      t.datetime :harvest_at
      t.string :responsable
      t.string :tractor_identifier
      t.string :tractor_driver
      t.integer :status, default: 0
      t.string :folio

      t.timestamps
    end
  end
end
