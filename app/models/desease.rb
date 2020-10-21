class Desease < ApplicationRecord
  has_many :crops_deseases, dependent: :destroy
  has_many :crops, through: :crops_deseases
  
  has_many :deseases_hosts, dependent: :destroy
  has_many :hosts, through: :deseases_hosts
  
  has_many :deseases_damages, dependent: :destroy
  has_many :damages, through: :deseases_damages

  has_many :treatments, as: :treatable, dependent: :destroy

  validates :name, :scientific_name, :pathogen, :desease_name, presence: true

  has_rich_text :development_conditions
  has_many_attached :pictures, dependent: :destroy

  delegate :get_crop_names, to: :crops, prefix: false

  accepts_nested_attributes_for :crops_deseases, allow_destroy: true
  accepts_nested_attributes_for :deseases_hosts, allow_destroy: true
  accepts_nested_attributes_for :deseases_damages, allow_destroy: true

  def self.get_desease_names
    pluck(:name, :id)
  end
end
