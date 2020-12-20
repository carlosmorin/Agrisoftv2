# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :supplies

  validates :name, presence: true
end
