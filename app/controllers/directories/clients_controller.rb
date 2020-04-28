module Directories
  class ClientsController < ApplicationController

  	add_breadcrumb "Directorios"
  	add_breadcrumb "Clientes", :directories_clients_path

  	def index
  		@clients = Client.paginate(page: params[:page], per_page: 12)
    	search if params[:q].present?
  	end

  private

  def search
    q = Regexp.escape(params[:q])
    
    @clients = @clients.where("concat(name, ' ', email, ' ', phone, ' ', contact_name) ~* ?", q)
  end

	def package_params
    params.require(:client).permit(:name, :email, :phone, :contact_name)
  end

  def set_object
    @client = Client.find(params[:id])
  end

  end
end