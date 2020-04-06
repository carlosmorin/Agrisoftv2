class CreateDrivers < ActiveRecord::Migration[6.0]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :last_name
      t.string :phone
      t.string :licence
      t.references :carrier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
