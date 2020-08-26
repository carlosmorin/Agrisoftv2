module Breadcrumbs::Logistic
	module BankAccounts
		extend ActiveSupport::Concern

		included do
	    add_breadcrumb "Logistica", :logistic_root_path
	    add_breadcrumb "Transportistas", :logistic_carriers_path
		end

		def build(action_name)
			case action_name	
			when "new", "create"
				breadrcumbs_new
			when "edit", "update"
				breadrcumbs_edit
			when "show"
				breadrcumbs_show
			end
		end

    def breadrcumbs_new
      add_breadcrumb @carrier.name.upcase, logistic_carrier_path(@carrier, tab: :bank_accounts)
      add_breadcrumb "Cuentas", logistic_carrier_path(@carrier, tab: :bank_accounts)
      add_breadcrumb "Nueva"
    end

    def breadrcumbs_edit
      add_breadcrumb @carrier.name.upcase, logistic_carrier_path(@carrier, tab: :bank_accounts)
      add_breadcrumb "Cuentas", logistic_carrier_path(@carrier, tab: :bank_accounts)
      add_breadcrumb "Editar"
    end

    def breadrcumbs_show
      add_breadcrumb @carrier.name.upcase, logistic_carrier_path(@carrier, tab: :bank_accounts)
      add_breadcrumb "Cuentas", logistic_carrier_path(@carrier, tab: :bank_accounts)
      add_breadcrumb "Detalle"
    end

    def set_carrier
      carrier_id = params[:carrier_id].present? ? params[:carrier_id] : @bank_account.accountable_id
      @carrier = Carrier.find(carrier_id)
    end

    def build_breadcrumbs
      build(action_name)
    end
  end
end