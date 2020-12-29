# frozen_string_literal: true

class DeseasesDamage < ApplicationRecord
  belongs_to :desease
  belongs_to :damage
end
