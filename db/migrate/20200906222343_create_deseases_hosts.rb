class CreateDeseasesHosts < ActiveRecord::Migration[6.0]
  def change
    create_table :deseases_hosts do |t|
      t.references :desease, null: false, foreign_key: true
      t.references :host, null: false, foreign_key: true

      t.timestamps
    end
  end
end
