module Config
	class ClientBrandsController < ApplicationController
		before_action :set_object, only: %i[edit update destroy]
		add_breadcrumb "Marcas", :config_client_brands_path

		def index
			@brands = ClientBrand.paginate(page: params[:page], per_page: 16)
      search if params[:q].present?
      search_by_client if params[:c].present?
		end

		def edit
			add_breadcrumb "Editar"
		end

		def show
			add_breadcrumb "Detalle"
		end

		def new
			add_breadcrumb "Nueva"
			@brand = ClientBrand.new
		end

		def create
			@brand = ClientBrand.new(brand_params)
			if @brand.save
				flash[:notice] = 'Marca creada'
				return redirect_to client_path(params[:c]) if params[:c].present?
				redirect_to config_client_brands_path
			else
				render :new, client_id: params[:c]
			end
		end
  	
		def update
			if @brand.update(brand_params)
				flash[:notice] = "Marca actualizada"
				redirect_to config_client_brands_path
			else
				render :edit
			end
		end
		
		def destroy
			@brand.destroy
		end

		private

		def search
			q = Regexp.escape(params[:q])
			@brands = @brands.where("name ~* ?", q)
		end

		def search_by_client
			client_id = Regexp.escape(params[:c])
			@brands = @brands.where(client_id: client_id)
		end

		def brand_params
			params.require(:client_brand).permit(:name, :client_id)
		end

		def set_object
			@brand = ClientBrand.find(params[:id])
		end
	end
end