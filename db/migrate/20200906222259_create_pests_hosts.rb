class CreatePestsHosts < ActiveRecord::Migration[6.0]
  def change
    create_table :pests_hosts do |t|
      t.references :pest, null: false, foreign_key: true
      t.references :host, null: false, foreign_key: true

      t.timestamps
    end
  end
end
