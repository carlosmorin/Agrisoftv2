# frozen_string_literal: true

module Addresses
  class CountriesController < ApplicationController
    before_action :set_object, only: %i[edit update destroy]
    add_breadcrumb 'Paises', :addresses_countries_path

    def index
      @countries = Country.all
    end

    def new
      add_breadcrumb 'Nuevo'
      @country = Country.new
    end

    def edit
      add_breadcrumb 'Editar'
    end

    def create
      @country = Country.new(country_params)
      if @country.save
        flash[:notice] = 'Pais creado'
        redirect_to addresses_countries_url
      else
        render :new
      end
    end

    def update
      if @country.update(country_params)
        flash[:notice] = 'Pais actualizado'
        redirect_to addresses_countries_url
      else
        render :edit
      end
    end

    def destroy
      @country.destroy
    end

    private

    def country_params
      params.require(:country).permit(:name, :short_name)
    end

    def set_object
      @country = Country.find(params[:id])
    end
  end
end
