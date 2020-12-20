# frozen_string_literal: true

class AddCodeToFreights < ActiveRecord::Migration[6.0]
  def change
    add_column :freights, :folio, :string
  end
end
