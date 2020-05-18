module ApplicationHelper
	def config?
    controller.class.name.split("::").first=="Config"
  end

  def current_link?(path)
	  "active_menu_item" if request.url.include?(path)
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
end
