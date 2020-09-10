class CreateAppioinments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.string :appointment_number
      t.string :n_request
			t.datetime :started_at
			t.datetime :finished_at
			t.datetime :appointment_at
			t.datetime :commitment_at
			t.references :shipment_id, foreign_key: true

      t.timestamps
    end
  end
end
