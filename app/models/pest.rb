class Pest < ApplicationRecord
  has_many :crops_pests, dependent: :destroy
  has_many :crops, through: :crops_pests

  has_many :pests_hosts, dependent: :destroy
  has_many :hosts, through: :pests_hosts

  has_many :pests_damages, dependent: :destroy
  has_many :damages, through: :pests_damages

  has_many_attached :pictures, dependent: :destroy
  has_rich_text :description

  validates :name, :scientific_name, presence: true
  #validate :pest_pictures

  delegate :name, to: :crops_pests, prefix: "crop", allow_nil: :true
  delegate :get_crop_names, to: :crops, prefix: false
  delegate :get_host_names, to: :hosts, prefix: false

  accepts_nested_attributes_for :crops_pests, allow_destroy: true
  accepts_nested_attributes_for :pests_hosts, allow_destroy: true
  accepts_nested_attributes_for :pests_damages, allow_destroy: true

  def self.get_pest_names
    pluck(:name, :id)
  end

  private

  # def pest_pictures
  #   if pictures.attached? == false
  #     errors.add(:pictures, "are missing!") 
  #   end
  #   pictures.each do |pic|
  #     if !pic.content_type.in?(%('image/jpeg image/png'))
  #       errors.add(:pictures, 'needs to be a JPEG or PNG')
  #     end
  #   end
  # end
end
