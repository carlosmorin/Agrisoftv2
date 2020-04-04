class CreateCarriers < ActiveRecord::Migration[6.0]
  def change
    create_table :carriers do |t|
      t.string :name
      t.string :rfc
      t.string :phone
      t.string :country
      t.string :state
      t.string :address
      t.string :cp
    end
  end
end
