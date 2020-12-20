# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :country
  belongs_to :state
  belongs_to :addressable, polymorphic: true
  enum status: %i[fiscal sucursal]
  validates :country_id, :state_id, :locality, :cp, presence: true
end
