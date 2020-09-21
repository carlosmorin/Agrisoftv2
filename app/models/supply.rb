class Supply < ApplicationRecord
  belongs_to :category

  validates :category_id, :name, :code, :currency, :iva, :ieps, presence: true
  validates :code, uniqueness: :true
  enum currency: [:mxn, :usd]

  delegate :name, to: :category, prefix: "category", allow_nil: :true

  has_many :active_ingredient_supplies
  has_many :active_ingredients, through: :active_ingredient_supplies

  accepts_nested_attributes_for :active_ingredient_supplies
end
