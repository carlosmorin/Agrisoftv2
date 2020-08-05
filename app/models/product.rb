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
  has_many :contracts_products, inverse_of: :product

  enum unit_meassure: { lbs: 0, kg: 1, granel: 2 }

  def short_name
    "#{crop.name} #{color.name}"
  end

  def origin
    
  end
  ## STATUS => lbs = libras, kg: kilogramas, granel: agrenel

  private

  def set_name
    size_name = size.short_name.present? ? size.short_name : size.name
    quality_name = quality.short_name.present? ? quality.short_name : quality.name
    self.name = "#{crop.name} #{color.name} #{quality_name} #{size_name} 
      #{package.name} #{client_brand.name} #{weight} #{unit_meassure}".upcase
  end

end
