module DriverBreadcrumb
	extend ActiveSupport::Concern

	def build_breadrcumbs(action_name)
		case action_name
		when "new"
			breadrcumbs_new
		when "edit"
			breadrcumbs_edit
		end
	end

	def breadrcumbs_new
		add_breadcrumb "Logistica", :logistic_root_path if params[:carrier_id].present?
		add_breadcrumb "Transportistas", :logistic_carriers_path if params[:carrier_id].present?
		add_breadcrumb @carrier.name.upcase, logistic_carrier_path(@carrier, tab: :operators) if params[:carrier_id].present?
		add_breadcrumb "Nuevo Conductor"
	end

	def breadrcumbs_edit
		add_breadcrumb "Logistica", :logistic_root_path if params[:carrier_id].present?
		add_breadcrumb "Transportistas", :logistic_carriers_path if params[:carrier_id].present?
		add_breadcrumb @carrier.name.upcase, logistic_carrier_path(@carrier, tab: :operators) if params[:carrier_id].present?
		add_breadcrumb "Operadores", logistic_carrier_path(@carrier, tab: :operators) if params[:carrier_id].present?
		add_breadcrumb @driver.name, logistic_carrier_driver_path(@carrier, @driver)
		add_breadcrumb "Editar"
	end

	def breadrcumbs_create
		add_breadcrumb "Logistica", :logistic_root_path
		add_breadcrumb "Transportistas", :logistic_carriers_path
		add_breadcrumb @carrier.name.upcase, logistic_carrier_path(@carrier, tab: :operators)
		add_breadcrumb "Nuevo Conductor"
	end
end