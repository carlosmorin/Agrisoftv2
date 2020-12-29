# frozen_string_literal: true

module Commercial
  class AddressesController < ApplicationController
    before_action :set_object, only: %i[show edit update destroy]

    def index
      @providers = Address.paginate(page: params[:page], per_page: 25)

      search if params[:q].present?
     end

    def new
      add_breadcrumb 'Nueva direccion'
      @address = Address.new
    end

    def edit
      add_breadcrumb 'Editar'
    end

    def show
      add_breadcrumb 'Gestionar proveedor'
    end

    def create
      @provider = Provider.new(provider_params)

      if @provider.save
        msg = "Proveedor creado correctamente <i class='fas fa-check-circle ml-2'></i>"
        flash[:notice] = msg
        redirect_to edit_commercial_provider_path(@provider, tab: params[:next_tab])
      else
        add_breadcrumb 'Nuevo proveedor'
        render :new
      end
    end

    def update
      if @provider.update(provider_params)
        msg = "Proveedor actualizado correctamente <i class='fas fa-check-circle ml-2'></i>"
        flash[:notice] = msg
        redirect_to edit_commercial_provider_path(@provider, tab: params[:next_tab])
      else
        render :edit
      end
   end

    def destroy
      @provider.destroy
    end

    private

    def search
      q = Regexp.escape(params[:q])

      @providers = @providers.where('name ~* ?', q)
    end

    def provider_params
      params.require(:provider).permit(:id, :name, :business_name, :rfc, :email,
                                       :phone, :status, :comments, :logo, :provider_category_id, :subcategory_id,
                                       addresses_attributes: %i[id name street outdoor_number
                                                                interior_number cp references neighborhood phone
                                                                country_id state_id comments status _destroy])
     end

    def set_object
      @provider = Provider.find(params[:id])
    end
  end
end
