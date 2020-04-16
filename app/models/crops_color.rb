class CropsColor < ApplicationRecord
  belongs_to :crop
  belongs_to :color

	validates_presence_of :crop_id
  validates_presence_of :color
end
