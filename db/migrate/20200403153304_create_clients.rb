class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :rfc
      t.string :phone
      t.string :country
      t.string :state
      t.string :cp
      t.string :address
    end
  end
end
