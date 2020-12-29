class AddFiscalToProviders < ActiveRecord::Migration[6.0]
  def change
    add_column :providers, :fiscal, :boolean
  end
end
