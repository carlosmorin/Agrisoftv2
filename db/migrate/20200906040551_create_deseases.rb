class CreateDeseases < ActiveRecord::Migration[6.0]
  def change
    create_table :deseases do |t|
      t.string :name
      t.string :scientific_name
      t.string :pathogen
      t.string :desease_name

      t.timestamps
    end
  end
end
