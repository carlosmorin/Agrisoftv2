module Reports
	class LumpsController < ApplicationController
  
  	def index
  		filter_clients if params[:c].present?
  	end

  	private

  	def filter_clients
  		@clients = params[:c][0].empty? ? Client.all : Client.find(params[:c])
  	end
  end
end