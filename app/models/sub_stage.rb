# frozen_string_literal: true

class SubStage < ApplicationRecord
  validates :name, presence: true
end
