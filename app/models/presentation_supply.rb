class PresentationSupply < ApplicationRecord
  belongs_to :supply
  belongs_to :presentation

  delegate :name, :id, :quantity, to: :presentation, prefix: true, allow_nil: true
end
