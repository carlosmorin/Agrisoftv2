module ApplicationHelper
	def config?
    controller.class.name.split("::").first=="Config"
  end

  def current_nav_item?(path, item)
  	current_nav_items = send("#{item}_menu_items")
  	current_nav_items.each do |nav_item|
  		return 'menu-open' if path.include?(nav_item)
  	end
  end
  
  def current_link?(path)
	  "active_menu_item bold" if request.url.include?(path)
	end

	def set_status(status)
		statuses = Shipment.statuses
		case status
		when 'sent'
		  "<span class='badge bg-primary btn btn-sm'> Enviado </span>"
		when 'in_reporting_process'
		  "<span class='badge bg-info btn btn-sm'> Reportando </span>"
		when 'in_payment_process'
		  "<span class='badge bg-info btn btn-sm'> Proceso de pago </span>"
		when 'liquidated'
		  "<span class='badge bg-success btn btn-sm'> Liquidada </span>"
		when 'canceled'
		  "<span class='badge bg-danger btn btn-sm'> Cancelada </span>"
		end
	end


	def packing_menu_items
		["shipments"]
	end

	def logistic_menu_items
		["logistic"]
	end

	def config_box_types_menu_items
		["config", "box_types"]
	end

	def commercial_menu_items
		["commercial"]
	end

	def clients_menu_items
		["clients", "expenses", "provider_categories"]
	end

	def valid_nil(str)
		str.nil? ? "--" : str
	end

	def valid_empty(obj)
		obj.empty? ? "--" : obj
	end
end
