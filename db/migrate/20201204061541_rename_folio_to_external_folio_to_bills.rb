# frozen_string_literal: true

class RenameFolioToExternalFolioToBills < ActiveRecord::Migration[6.0]
  def change
    rename_column :bills, :folio, :external_folio
  end
end
