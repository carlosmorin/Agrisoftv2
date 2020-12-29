# frozen_string_literal: true

class DeseasesHost < ApplicationRecord
  belongs_to :desease
  belongs_to :host
end
