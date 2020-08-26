class Bank < ApplicationRecord
  has_many :bank_accounts, inverse_of: :bank
end
