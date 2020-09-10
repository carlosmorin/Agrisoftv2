class RenameDateName < ActiveRecord::Migration[6.0]
  def change
    rename_column :appointments, :startet_at, :started_at
  end
end
