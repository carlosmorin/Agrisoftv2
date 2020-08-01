class Provider < ApplicationRecord
	acts_as_paranoid
  default_scope { order(:created_at) }
  validates :name, :phone, presence: true
	has_rich_text :comments
  has_one_attached :logo

  enum status: [:active, :inactive]
end
