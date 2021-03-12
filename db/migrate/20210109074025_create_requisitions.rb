class CreateRequisitions < ActiveRecord::Migration[6.0]
  def change
    create_table :requisitions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :department
      t.string :folio
      t.text :comments
      t.datetime :limit_at
      t.integer :priority, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
