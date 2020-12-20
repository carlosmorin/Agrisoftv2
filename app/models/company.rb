# frozen_string_literal: true

class Company < ApplicationRecord
  acts_as_paranoid
  default_scope { order(:created_at) }
  validates :name, :rfc, :country_id, :state_id, :municipality_id,
            :cp, :address, :phone, presence: true
  belongs_to :country
  belongs_to :state
  belongs_to :municipality
  has_many :remissions, inverse_of: :company
  has_many :freights, as: :debtable, inverse_of: :company

  def origin_state
    state.name.to_s.upcase
  end

  def full_address
    "#{municipality.name}, #{state.name}, #{address}, #{country.name}"
  end
end
