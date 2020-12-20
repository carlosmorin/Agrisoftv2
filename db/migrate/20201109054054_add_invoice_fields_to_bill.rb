# frozen_string_literal: true

class AddInvoiceFieldsToBill < ActiveRecord::Migration[6.0]
  def change
    add_column :bills, :pre_billed_at, :datetime
    add_column :bills, :folio, :string
  end
end
