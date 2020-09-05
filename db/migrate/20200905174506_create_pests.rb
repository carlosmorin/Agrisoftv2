class CreatePests < ActiveRecord::Migration[6.0]
  def change
    create_table :pests do |t|
      t.string :name
      t.string :scientific_name

      t.timestamps
    end
  end
end
