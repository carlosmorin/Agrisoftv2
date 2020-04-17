class Product < ApplicationRecord
  validates :crop_id, :client_brand_id, :color_id, :quality_id, :size_id, :package_id, presence: true
  belongs_to :crop
  belongs_to :color
  belongs_to :quality
  belongs_to :size
  belongs_to :package
  belongs_to :client_brand
end
