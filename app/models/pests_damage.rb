# frozen_string_literal: true

class PestsDamage < ApplicationRecord
  belongs_to :pest
  belongs_to :damage
end
