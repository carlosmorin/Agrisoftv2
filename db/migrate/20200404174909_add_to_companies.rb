class AddToCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :rfc
      t.string :phone
      t.references :country, null: false, foreign_key: true
      t.references :state, null: false, foreign_key: true
      t.references :municipality, null: false, foreign_key: true
      t.string :cp, null: false, foreign_key: true
      t.string :address
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
