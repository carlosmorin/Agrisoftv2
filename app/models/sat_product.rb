class SatProduct < ApplicationRecord
  def full_name
    "#{key} - #{name}"
  end
end
