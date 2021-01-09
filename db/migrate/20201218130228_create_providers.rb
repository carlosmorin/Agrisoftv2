class CreateProviders < ActiveRecord::Migration[6.0]
  def change
    remove_table :providers
    create_table :providers do |t|
      t.string :code
      t.string :name
      t.string :provider_type
      t.decimal :credit_limit
      t.integer :credit_limit_days
      t.integer :delivery_days
      t.references :currency, null: false, foreign_key: true
      t.references :provider_category, null: false, foreign_key: true
      t.references :subcategory, null: false, foreign_key: true
      t.references :delivery_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
