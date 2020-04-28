class CreateUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :units do |t|
      t.string :model
      t.string :color
      t.string :year
      t.string :n_econ
      t.string :plate_number
      t.references :carrier, null: false, foreign_key: true
      t.references :unit_brand, null: false, foreign_key: true
    end
  end
end
