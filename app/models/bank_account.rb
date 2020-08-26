class BankAccount < ApplicationRecord
  belongs_to :bank
  belongs_to :currency
  belongs_to :accountable, polymorphic: true
  validates :name, :bank_id, :currency_id, presence: true
	has_rich_text :comments
end
