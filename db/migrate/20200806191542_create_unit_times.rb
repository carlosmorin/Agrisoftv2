class CreateUnitTimes < ActiveRecord::Migration[6.0]
  def change
    create_table :unit_times do |t|
      t.string :name

      t.timestamps
    end
  end
end
