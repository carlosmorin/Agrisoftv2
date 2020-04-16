class CreateCropsSizes < ActiveRecord::Migration[6.0]
  def change
    create_table :crops_sizes do |t|
      t.references :crop, null: false, foreign_key: true
      t.references :size, null: false, foreign_key: true

      t.timestamps
    end
  end
end
