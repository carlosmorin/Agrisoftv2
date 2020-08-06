class AddUndifiniedToContract < ActiveRecord::Migration[6.0]
  def change
    add_column :contracts, :undefined, :boolean
  end
end
