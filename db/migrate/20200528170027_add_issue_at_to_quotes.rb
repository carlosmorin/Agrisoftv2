# frozen_string_literal: true

class AddIssueAtToQuotes < ActiveRecord::Migration[6.0]
  def change
    add_column :quotes, :issue_at, :datetime
  end
end
