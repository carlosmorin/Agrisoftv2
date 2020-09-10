class CropsDesease < ApplicationRecord
  belongs_to :crop
  belongs_to :desease

  delegate :name, to: :crop
end
