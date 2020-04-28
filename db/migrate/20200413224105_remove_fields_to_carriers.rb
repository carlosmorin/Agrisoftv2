class RemoveFieldsToCarriers < ActiveRecord::Migration[6.0]
  def change
  	remove_column :carriers, :municipality
  end
end
