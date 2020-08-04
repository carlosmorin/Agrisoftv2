class Provider < ApplicationRecord
	acts_as_paranoid
  default_scope { order(:created_at) }
  validates :name, :phone, :provider_category_id, :subcategory_id, :status, presence: true
  has_many :addresses, as: :addressable, dependent: :destroy
	
	has_rich_text :comments
  has_one_attached :logo

  belongs_to :provider_category
  belongs_to :subcategory

  enum status: [:active, :inactive]
	
	accepts_nested_attributes_for :addresses, allow_destroy: true
end
