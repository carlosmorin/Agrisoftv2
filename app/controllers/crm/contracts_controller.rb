module Crm
  class ContractsController < ApplicationController
		before_action :set_object, only: %i[show edit update]
		add_breadcrumb "CRM", :crm_root_url
    add_breadcrumb "Clientes", :crm_clients_url

		def new
			@contract = Contract.new(client_id: params[:client_id])

			add_breadcrumb @contract.client.name.upcase, crm_client_path(@contract.client_id, tab: :contracts)
			add_breadcrumb "Contratos", crm_client_path(@contract.client_id, tab: :contracts)
			add_breadcrumb "Nuevo"
			@contract.contracts_products.new
			@contract.contracts_expenses.new
		end

		def create
			if contract_params[:started_at] .present?
				dates = contract_params[:started_at].split(" to ")
				@contract = Contract.new(contract_params.merge!(started_at: dates.first, finished_at: dates.last))
			else 
				@contract = Contract.new(contract_params)
			end

			add_breadcrumb @contract.client.name.upcase, crm_client_path(@contract.client_id, tab: :contracts)
			add_breadcrumb "Contratos", crm_client_path(@contract.client_id, tab: :contracts)
			add_breadcrumb "Nuevo"
			
			if @contract.save
				flash[:notice] =  "<i class='fa fa-check-circle mr-1 s-18'></i> Contracto registrado correctamente"
				redirect_to crm_client_path(@contract.client_id, tab: :contracts) 
			else
				@contract
				render :new
			end
    end

		def update
      if @contract.update(contract_params)
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Contrato actualizado correctamente"
        redirect_to crm_client_path(@contract.client_id, tab: :contracts) 
      else
        render :edit
      end
    end

		private

		def contract_params
			params.require(:contract).permit(:name, :client_id, :started_at, 
				:finished_at, :all_products, :delivery_address_id, :user_id, :undefined,
				:comments, contracts_products_attributes: [:id, :contract_id, 
					:product_id, :currency_id, :quantity, :price, :_destroy],
				contracts_expenses_attributes: [:id, :contract_id, :expense_id, :_destroy]
			)
		end

		def set_object
			@contract = Contract.find(params[:id])
		end
	end
end