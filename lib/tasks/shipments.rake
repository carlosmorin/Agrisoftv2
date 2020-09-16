namespace :shipments do
  desc "TODO"
  task folios_update: :environment do
  	Shipment.all.each do |shipment|
  		shipment.update(shipment_at: shipment.updated_at)
  	end
  	puts "folios_update task done"
  end

end
