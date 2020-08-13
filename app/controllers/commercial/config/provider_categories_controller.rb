module Commercial
  module Config
    class ProviderCategoriesController < ApplicationController
    	before_action :set_object, only: %i[edit update destroy get_subcategories]
      
      add_breadcrumb "Comercial", :commercial_root_path
    	add_breadcrumb "Proveedores", :commercial_providers_path
      add_breadcrumb "Configuración", :commercial_config_root_path
      add_breadcrumb "Categorías de proveedores", :commercial_config_provider_categories_path

    	def index
      	@categories = ProviderCategory.paginate(page: params[:page], per_page: 16)

        search if params[:q].present?
      end

      def new
        add_breadcrumb "Nuevo Categoría"
      	@category = ProviderCategory.new
        @category.subcategories.build
      end

      def edit
        add_breadcrumb "Editar"
      end	

      def create
        @category = ProviderCategory.new(provider_category_params)
        
        if @category.save
          msg = "<i class='fas fa-check-circle mr-2'></i> Categoría creada correctamente "
          flash[:notice] = msg
          redirect_to commercial_config_provider_categories_path
        else
          add_breadcrumb "Nuevo Categoría"
          render :new
        end
      end

       def update
        if @category.update(provider_category_params)
          msg = "<i class='fas fa-check-circle mr-2'></i> Categoría actualizada correctamente"
          flash[:notice] = msg
          redirect_to commercial_config_provider_categories_path
        else
          render :edit
        end
      end

      def destroy
        @category.destroy
      end

      def get_subcategories
        render json: @category.subcategories 
      end

    	private

      def search
        q = Regexp.escape(params[:q])
        
        @categories = @categories.where("name ~* ?", q)
      end

    	def provider_category_params
        params.require(:provider_category).permit(:name,
          subcategories_attributes: [:id, :name, :description, :categorytable_type, :categorytable_id, :_destroy])
      end

      def set_object
        id = params[:id].present? ? params[:id] : params[:provider_category_id]
        @category = ProviderCategory.find(id)
      end
    end
  end
end