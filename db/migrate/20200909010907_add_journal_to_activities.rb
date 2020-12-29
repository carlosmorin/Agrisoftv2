# frozen_string_literal: true

class AddJournalToActivities < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :jornals, :decimal, precision: 8, scale: 2
  end
end
