# frozen_string_literal: true

module Addresses
  class StatesController < ApplicationController
    before_action :set_object, only: %i[edit update destroy]
    before_action :set_countries, only: %i[edit new create update]
    add_breadcrumb 'Estados', :addresses_states_path

    def index
      @states = State.paginate(page: params[:page], per_page: 18)
    end

    def new
      add_breadcrumb 'Nuevo'
      @state = State.new
    end

    def edit
      add_breadcrumb 'Editar'
    end

    def create
      @state = State.new(state_params)
      if @state.save
        flash[:notice] = 'Estado creado'
        redirect_to addresses_states_url
      else
        render :new, collection: @countries
      end
    end

    def update
      if @state.update(state_params)
        flash[:notice] = 'Estado actualizado'
        redirect_to addresses_states_url
      else
        render :edit, collection: @countries
      end
    end

    def destroy
      @state.destroy
    end

    private

    def state_params
      params.require(:state).permit(:name, :short_name, :country_id)
    end

    def set_object
      @state = State.find(params[:id])
    end

    def set_countries
      @countries = Country.all
    end
  end
end
