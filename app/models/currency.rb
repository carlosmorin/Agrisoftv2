class Currency < ApplicationRecord
  validates :name, :code, presence: true
  scope :national, -> { where(national: true) }
end
