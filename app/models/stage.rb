# frozen_string_literal: true

class Stage < ApplicationRecord
  validates :name, presence: true
end
