# frozen_string_literal: true

class FreightsTax < ApplicationRecord
  belongs_to :freight, optional: true
  belongs_to :tax, optional: true
end
