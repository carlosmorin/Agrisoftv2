# frozen_string_literal: true

module SatHelper
  def sat_product_name(sat_product_key)
    return if sat_product_key.nil?

    sp = SatProduct.find_by_key(sat_product_key)
    "#{sp.key}-#{sp.name}".upcase
  end

  def sat_unit_name(sat_unit_key)
    return if sat_unit_key.nil?

    sum = SatUnitMeasure.find_by_key(sat_unit_key)
    "#{sum.key}-#{sum.name}".upcase
  end

  def sat_product_collection(sat_product_key)
    return if sat_product_key.nil?
    SatProduct.where(key: sat_product_key).collect{ |u| [u.full_name, u.key] }
  end

  def sat_unit_collection(sat_unit_key)
    return if sat_unit_key.nil?
    SatUnitMeasure.where(key: sat_unit_key).collect{ |u| [u.full_name, u.key] }
  end
end
