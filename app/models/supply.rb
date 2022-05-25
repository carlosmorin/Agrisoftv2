# frozen_string_literal: true

class Supply < ApplicationRecord
  belongs_to :category

  validates :category_id, :name, :code, :currency, :iva, :ieps, presence: true
  validates :code, uniqueness: :true
  enum currency: %i[mxn usd]
  scope :stock, -> { where(stockable: true) }
  scope :not_stock, -> { where(stockable: false) }

  delegate :name, to: :category, prefix: 'category', allow_nil: :true

  has_many :active_ingredient_supplies, dependent: :destroy
  has_many :active_ingredients, through: :active_ingredient_supplies

  has_many :presentation_supplies, dependent: :destroy
  has_many :presentations, through: :presentation_supplies

  has_many :treatment_supplies, dependent: :destroy
  has_many :providers_supplies, dependent: :destroy
  has_many :providers, :through => :providers_supplies

  has_many_attached :pictures

  accepts_nested_attributes_for :active_ingredient_supplies, allow_destroy: true
  accepts_nested_attributes_for :presentation_supplies, allow_destroy: true
end
