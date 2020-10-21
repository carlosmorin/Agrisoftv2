class CreatePresentationSupplies < ActiveRecord::Migration[6.0]
  def change
    create_table :presentation_supplies do |t|
      t.references :supply, null: false, foreign_key: true
      t.references :presentation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
