class CreateCropsQualities < ActiveRecord::Migration[6.0]
  def change
    create_table :crops_qualities do |t|
      t.references :crop, null: false, foreign_key: true
      t.references :quality, null: false, foreign_key: true

      t.timestamps
    end
  end
end
