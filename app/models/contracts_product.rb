class ContractsProduct < ApplicationRecord
  belongs_to :contract, optional: true
  belongs_to :product, optional: true
  belongs_to :currency, optional: true
end
