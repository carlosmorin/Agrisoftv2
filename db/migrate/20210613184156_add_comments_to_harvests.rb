class AddCommentsToHarvests < ActiveRecord::Migration[6.0]
  def change
    add_column :harvests, :comments, :text
  end
end
