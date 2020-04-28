class CreateBoxes < ActiveRecord::Migration[6.0]
  def change
    create_table :boxes do |t|
      t.string :temperature
      t.string :plate_number
      t.string :n_econ
      t.references :carrier, null: false, foreign_key: true
      t.references :box_type, null: false, foreign_key: true

      t.timestamps
      t.datetime :deleted_at
    end
  end
end
