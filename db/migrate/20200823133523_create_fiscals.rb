class CreateFiscals < ActiveRecord::Migration[6.0]
  def change
    create_table :fiscals do |t|
      t.string :bussiness_name
      t.string :rfc
      t.references :fiscalable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
