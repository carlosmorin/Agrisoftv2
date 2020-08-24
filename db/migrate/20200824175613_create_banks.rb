class CreateBanks < ActiveRecord::Migration[6.0]
  def change
    create_table :banks do |t|
      t.string :name
      t.string :full_name
      t.string :key

      t.timestamps
    end
  end
end
