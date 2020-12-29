# frozen_string_literal: true

class Damage < ApplicationRecord
  validates :name, presence: true

  has_many :pests_damages, dependent: :destroy
  has_many :pests, through: :pests_damages

  has_many :deseases_damages, dependent: :destroy
  has_many :deseases, through: :deseases_damages

  accepts_nested_attributes_for :pests_damages, allow_destroy: true
  accepts_nested_attributes_for :deseases_damages, allow_destroy: true

  has_rich_text :description
  has_one_attached :picture

  delegate :get_pest_names, to: :pests, prefix: false
  delegate :get_desease_names, to: :deseases, prefix: false

  def self.get_damage_names
    pluck(:name, :id)
  end
end
