# frozen_string_literal: true

class AllowNilForUserIdOnActivities < ActiveRecord::Migration[6.0]
  def change
    change_column :activities, :user_id, :bigint, null: true
  end
end
