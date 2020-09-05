class Crop < ApplicationRecord
  acts_as_paranoid
  default_scope { order(:created_at) }
  validates :name, presence: true

  has_many :crops_pests
  has_many :pests, through: :crops_pests
  accepts_nested_attributes_for :crops_pests, allow_destroy: true

  has_many :crops_colors
  has_many :colors, through: :crops_colors
  accepts_nested_attributes_for :crops_colors, allow_destroy: true

  has_many :crops_sizes
  has_many :sizes, through: :crops_sizes
  accepts_nested_attributes_for :crops_sizes, allow_destroy: true

  has_many :crops_qualities
  has_many :qualities, through: :crops_qualities
  accepts_nested_attributes_for :crops_qualities, allow_destroy: true

  has_many :crops_packages
  has_many :packages, through: :crops_packages
  accepts_nested_attributes_for :crops_packages, allow_destroy: true
end