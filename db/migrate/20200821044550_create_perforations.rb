class CreatePerforations < ActiveRecord::Migration[6.0]
  def change
    create_table :perforations do |t|
      t.string :name
      t.string :coordinates
      t.string :registry_number
      t.string :volume
      t.date :validity
      t.decimal :expenditure
      t.references :ranch, null: false, foreign_key: true

      t.timestamps
    end
  end
end
