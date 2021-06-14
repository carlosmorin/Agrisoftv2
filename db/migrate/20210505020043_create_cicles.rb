class CreateCicles < ActiveRecord::Migration[6.0]
  def change
    create_table :cicles do |t|
      t.string :name
      t.references :crop, null: false, foreign_key: true
      t.references :ranch, null: false, foreign_key: true

      t.timestamps
    end
  end
end
