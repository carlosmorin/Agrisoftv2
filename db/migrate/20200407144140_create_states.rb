class CreateStates < ActiveRecord::Migration[6.0]
  def change
    create_table :states do |t|
      t.string :key
      t.string :name
      t.string :short_name
      t.boolean :active
      
      t.timestamps
    end
  end
end
