class Supply < ApplicationRecord
  belongs_to :category

  enum currency: [:mxn, :usd]
  
  validates :category_id, :name, :code, :currency, :iva, :ieps, presence: true
  validates :code, uniqueness: :true

  delegate :name, to: :category, prefix: "category", allow_nil: :true
end
