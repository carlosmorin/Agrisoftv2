class AddToCompanies < ActiveRecord::Migration[6.0]
  def change
  	add_column :companies, :name, :string
  	add_column :companies, :rfc, :string
  	add_column :companies, :phone, :string
  	add_column :companies, :country, :string
  	add_column :companies, :state, :string
  	add_column :companies, :cp, :string
  	add_column :companies, :address, :string
  	add_column :companies, :deleted_at, :datetime
  end
end
