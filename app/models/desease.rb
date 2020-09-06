class Desease < ApplicationRecord
  has_many :crops_deseases, dependent: :destroy
  has_many :crops, through: :crops_deseases
  accepts_nested_attributes_for :crops_deseases, allow_destroy: true
  validates :name, :scientific_name, :pathogen, :desease_name, presence: true

  has_rich_text :development_conditions
  has_many_attached :pictures, dependent: :destroy

  delegate :get_crop_names, to: :crops, prefix: false
end
