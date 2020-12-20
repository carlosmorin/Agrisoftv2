# frozen_string_literal: true

class AddShortnameToSizes < ActiveRecord::Migration[6.0]
  def change
    add_column :sizes, :short_name, :string
  end
end
