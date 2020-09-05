class CropsPest < ApplicationRecord
  belongs_to :crop
  belongs_to :pest
end
