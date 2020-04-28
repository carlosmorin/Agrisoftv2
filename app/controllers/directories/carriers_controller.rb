module Directories
  class CarriersController < ApplicationController

  	add_breadcrumb "Directorios"
  	add_breadcrumb "Transportistas", :directories_carriers_path

  	def index
  		@carriers = Carrier.paginate(page: params[:page], per_page: 12)
    	search if params[:q].present?
  	end

  private

  def search
    q = Regexp.escape(params[:q])
    
    @carriers = @carriers.where("concat(name, ' ', email, ' ', phone, ' ', contact_name) ~* ?", q)
  end

	def package_params
    params.require(:carrier).permit(:name, :email, :phone, :contact_name)
  end

  def set_object
    @carrier = Carrier.find(params[:id])
  end

  end
end