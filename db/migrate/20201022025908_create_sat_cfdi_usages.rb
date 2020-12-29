# frozen_string_literal: true

class CreateSatCfdiUsages < ActiveRecord::Migration[6.0]
  def change
    create_table :sat_cfdi_usages do |t|
      t.string :descripcion
      t.boolean :physical_person
      t.boolean :moral_person

      t.timestamps
    end
  end
end
