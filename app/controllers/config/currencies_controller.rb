module Config
	class CurrenciesController < ApplicationController
		before_action :set_object, only: %i[edit update destroy]
		add_breadcrumb "Monedas", :config_currencies_path

		def index
			@currencies = Currency.paginate(page: params[:page], per_page: 25)
			@currency = Currency.new
      
      search if params[:q].present?
		end

		def edit
			add_breadcrumb "Editar"
		end

		def show
			add_breadcrumb "Detalle"
		end


		def create
			@currency = Currency.new(currency_params)
			if @currency.save
				flash[:notice] = "<i class='fa fa-check-circle mr-2'></i> Nueva moneda creada"
				return redirect_to config_currencies_path(params[:c]) if params[:c].present?
				redirect_to config_currencies_path
			else

			end
		end
  	
		def update
			if @currency.update(currency_params)
				flash[:notice] = " <i class='fa fa-check-circle mr-2'></i> Moneda actualizada"
				redirect_to config_currencies_path
			else
				render :edit
			end
		end
		
		def destroy
			@currency.destroy
		end

		private

		def search
			q = Regexp.escape(params[:q])
			@currencies = @currencies.where("name ~* ?", q)
		end

		def currency_params
			params.require(:currency).permit(:name, :code, :national)
		end

		def set_object
			@currency = Currency.find(params[:id])
		end
	end
end