module DriverBreadcrumb
	extend ActiveSupport::Concern

	def build_breadrcumbs(action_name)
		case action_name
		when "new"
			breadrcumbs_new
		end
	end

	def breadrcumbs_new
		add_breadcrumb "Logistica", :logistic_root_path if params[:carrier_id].present?
		add_breadcrumb "Transportistas", :logistic_carriers_path if params[:carrier_id].present?
		add_breadcrumb @carrier.name.upcase, logistic_carrier_path(@carrier, tab: :operators) if params[:carrier_id].present?
		add_breadcrumb "Nuevo Conductor"
	end

	def breadrcumbs_create
		add_breadcrumb "Logistica", :logistic_root_path
		add_breadcrumb "Transportistas", :logistic_carriers_path
		add_breadcrumb @carrier.name.upcase, logistic_carrier_path(@carrier, tab: :operators)
		add_breadcrumb "Nuevo Conductor"
	end
end