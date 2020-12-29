# frozen_string_literal: true

class CreateGeneralInformation < ActiveRecord::Migration[6.0]
  def change
    create_table :general_information do |t|
      t.string :name
      t.string :last_name
      t.datetime :born_date
      t.string :alias
      t.string :level_studies
      t.string :school_name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
