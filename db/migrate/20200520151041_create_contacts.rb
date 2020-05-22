class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :mobile_phone
      t.string :position
      t.integer :alias
      t.references :contactable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
