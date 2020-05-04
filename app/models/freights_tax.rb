class FreightsTax < ApplicationRecord
  belongs_to :freight
  belongs_to :tax
  validates :tax_id, presence: true

end
