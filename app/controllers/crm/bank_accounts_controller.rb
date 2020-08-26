module Crm
  class BankAccountsController < ApplicationController
    include Breadcrumbs::Crm::BankAccounts

  	before_action :set_object, only: %i[show edit update destroy]
  	before_action :set_client, only: %i[new edit show]
  	before_action :build_breadcrumbs, only: %i[new edit show]

		def new
			@bank_account = BankAccount.new
		end
		
		def edit
		end

		def show
		end

		def create
			@bank_account = BankAccount.new(bank_account_params)
			if @bank_account.save
				flash[:notice] =  "<i class='fa fa-check-circle mr-1 s-18'></i> Cuenta creada correctamente"
				redirect_to crm_client_path(@bank_account.accountable, tab: :bank_accounts)
			else
				set_client
				build_breadcrumbs
				render :new
			end
    end

		def update
      if @bank_account.update(bank_account_params)
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Cuenta actualizada correctamente"
        redirect_to crm_client_path(@bank_account.accountable, tab: :bank_accounts)
      else
				set_client
				build_breadcrumbs
        render :edit
      end
    end

		private

		def bank_account_params
			params.require(:bank_account).permit(:bank_id, :currency_id, :name, 
				:titular, :bank_key, :account_number, :card_number, :branch,
				:accountable_type, :accountable_id, :comments)
		end

		def set_object
			@bank_account = BankAccount.find(params[:id])
		end
	end
end