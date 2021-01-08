class AddStatusToProviders < ActiveRecord::Migration[6.0]
  def change
    add_column :providers, :status, :integer, default: 0
  end
end
