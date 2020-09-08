class CreateDeseasesDamages < ActiveRecord::Migration[6.0]
  def change
    create_table :deseases_damages do |t|
      t.references :desease, null: false, foreign_key: true
      t.references :damage, null: false, foreign_key: true

      t.timestamps
    end
  end
end
