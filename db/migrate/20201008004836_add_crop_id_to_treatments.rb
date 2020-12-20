# frozen_string_literal: true

class AddCropIdToTreatments < ActiveRecord::Migration[6.0]
  def change
    add_reference :treatments, :crop, null: false, foreign_key: true
  end
end
