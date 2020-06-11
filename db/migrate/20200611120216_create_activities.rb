class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.references :user, null: false, foreign_key: true
      t.string :url
      t.string :action
      t.string :ip_address

      t.timestamps
    end
  end
end
