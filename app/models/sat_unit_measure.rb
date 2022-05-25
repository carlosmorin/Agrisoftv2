class SatUnitMeasure < ApplicationRecord
  def full_name
    "#{key} - #{name}"
  end
end
