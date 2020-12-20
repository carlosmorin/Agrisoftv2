# frozen_string_literal: true

class PestsHost < ApplicationRecord
  belongs_to :pest
  belongs_to :host
end
