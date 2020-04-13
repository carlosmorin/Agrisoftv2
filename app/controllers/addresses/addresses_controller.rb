module Addresses
  class AddressesController < ApplicationController
  	def states
  		@states = Country.find(params[:country_id]).states
  		render json: @states
  	end

  	def municipalities
  		@municipalities = State.find(params[:state_id]).municipalities
  		render json: @municipalities
  	end

    def locations
      @locations = Municipality.find(params[:location_id]).locations
      render json: @locations
    end
  end
end