class FreightsTax < ApplicationRecord
  belongs_to :freight, optional: true
  belongs_to :tax
end
