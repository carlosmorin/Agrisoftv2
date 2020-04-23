module Addresses
  class MunicipalitiesController < ApplicationController
    before_action :set_object, only: %i[edit update destroy]
    before_action :set_countries, only: %i[edit new create update]
    add_breadcrumb "Municipios", :addresses_municipalities_path

    def index
      @municipalities = Municipality.paginate(page: params[:page], per_page: 18)
    end

    def new
      add_breadcrumb "Nuevo"
      @municipality = Municipality.new
    end

    def edit
      add_breadcrumb "Editar"
    end

    def create
      @municipality = Municipality.new(municipality_params)
      if @municipality.save
        flash[:notice] = 'Municipio creado'
        redirect_to addresses_municipalities_url
      else
        render :new, collection: @municipalities
      end
    end

    def update
      if @municipality.update(municipality_params)
        flash[:notice] = "Estado actualizado"
        redirect_to addresses_municipalities_url
      else
        render :edit, collection: @municipalities
      end
    end

    def destroy
      @municipality.destroy
    end

    private

    def municipality_params
      params.require(:municipality).permit(:name, :country_id)
    end

    def set_object
      @municipality = Municipality.find(params[:id])
    end

    def set_countries
      @countries = Country.all
    end
  end
end