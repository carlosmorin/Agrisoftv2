class AddDeletedAtToTaxes < ActiveRecord::Migration[6.0]
  def change
  	add_column :taxes, :deleted_at, :datetime
  end
end
