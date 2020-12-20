# frozen_string_literal: true

namespace :shipments do
  desc 'TODO'
  task folios_update: :environment do
    Shipment.all.each do |shipment|
      shipment.update(shipment_at: shipment.updated_at)
    end
    puts 'folios_update task done'
  end

  task upadte_nil_quantity: :environment do
    ShipmentsProduct.all.each do |_sp|
      return unless quantity.nil?

      shipment.update(quantity: 0)
    end
    puts 'nil quantity updated to 0'
  end

  task upadte_nil_price: :environment do
    ShipmentsProduct.all.each do |_sp|
      return unless price.nil?

      shipment.update(price: 0)
    end
    puts 'nil price updated to 0'
  end
end
