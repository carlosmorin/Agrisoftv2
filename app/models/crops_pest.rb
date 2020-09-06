class CropsPest < ApplicationRecord
  belongs_to :crop
  belongs_to :pest

  delegate :name, to: :crop
end
