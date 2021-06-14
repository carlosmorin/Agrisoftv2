class HarvestLog < ApplicationRecord
  belongs_to :crop
  belongs_to :area
  belongs_to :production_unit
  belongs_to :harvest
  validates :n_items, presence: true
end
