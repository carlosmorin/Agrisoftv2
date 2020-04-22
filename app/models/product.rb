class Product < ApplicationRecord
  before_create :set_name
  before_update :set_name

  validates :crop_id, :client_brand_id, :color_id, :quality_id, :size_id, 
    :weight, :unit_meassure, :package_id, presence: true
  belongs_to :crop
  belongs_to :color
  belongs_to :quality
  belongs_to :size
  belongs_to :package
  belongs_to :client_brand

  has_many :shipments_products, inverse_of: :product
  has_many :shipments, through: :shipments_products

  private

  def set_name
    self.name = "#{crop.name} #{color.name} #{quality.name} #{size.name} 
      #{package.name} #{client_brand.name}"
  end
end
