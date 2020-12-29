class AddDeletedAtToProviders < ActiveRecord::Migration[6.0]
  def change
    add_column :providers, :deleted_at, :datetime
  end
end
