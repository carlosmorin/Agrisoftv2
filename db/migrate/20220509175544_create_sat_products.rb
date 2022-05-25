class CreateSatProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :sat_products do |t|
      t.string :key
      t.string :name

      t.timestamps
    end
  end
end
