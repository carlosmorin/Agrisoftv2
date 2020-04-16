class Quality < ApplicationRecord
	acts_as_paranoid
  default_scope { order(:created_at) }
  validates :name, presence: true

  has_many :crops_qualities
  has_many :crops, through: :crops_qualities
end
