class AddFolioToBills < ActiveRecord::Migration[6.0]
  def change
    add_column :bills, :serie, :string
  end
end
