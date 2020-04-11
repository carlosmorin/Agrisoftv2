module Addresses
  class AddressesController < ApplicationController
  	def states
  		@states = State.where(country_id: params[:country_id])
  		render json: @states
  	end
  end
end