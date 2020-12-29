# frozen_string_literal: true

class Host < ApplicationRecord
  validates :name, presence: true

  has_many :pests_hosts, dependent: :destroy
  has_many :pests, through: :pests_hosts

  has_many :deseases_hosts, dependent: :destroy
  has_many :deseases, through: :deseases_hosts

  accepts_nested_attributes_for :pests_hosts, allow_destroy: true
  accepts_nested_attributes_for :deseases_hosts, allow_destroy: true

  has_rich_text :description
  has_one_attached :picture

  delegate :get_pest_names, to: :pests, prefix: false
  delegate :get_desease_names, to: :deseases, prefix: false

  def self.get_host_names
    pluck(:name, :id)
  end
end
