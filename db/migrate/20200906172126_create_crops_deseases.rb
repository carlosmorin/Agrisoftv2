class CreateCropsDeseases < ActiveRecord::Migration[6.0]
  def change
    create_table :crops_deseases do |t|
      t.references :crop, null: false, foreign_key: true
      t.references :desease, null: false, foreign_key: true

      t.timestamps
    end
  end
end
