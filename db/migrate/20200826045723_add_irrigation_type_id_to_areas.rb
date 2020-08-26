class AddIrrigationTypeIdToAreas < ActiveRecord::Migration[6.0]
  def change
    add_column :areas, :irrigation_type_id, :bigint, foreign_key: true

    add_index :areas, :irrigation_type_id

    remove_column :areas, :type_of_irrigation
  end
end
