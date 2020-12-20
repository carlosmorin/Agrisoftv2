module Crm
  class FiscalsController < ApplicationController
    before_action :set_object, only: %i[edit update destroy show]
    before_action :set_client, only: %i[new edit]

    def new
    	@fiscal = Fiscal.new()
    end

    def edit; end
    def show; end

    def create
    	@fiscal = Fiscal.new(fiscal_params)
    	if @fiscal.save
    		flash[:notice] =  "<i class='fa fa-check-circle mr-1 s-18'></i> Razón social registrada correctamente"
    		redirect_to crm_client_path(@fiscal.fiscalable, tab: :fiscal_names)
    	else
				render :new
    	end
    end

    def update
      if @fiscal.update(fiscal_params)
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Razón social actualizada correctamente"
        redirect_to crm_client_path(@fiscal.fiscalable, tab: :fiscal_names)
      else
        render :edit
      end
    end
    
    private
      def fiscal_params
        params.require(:fiscal).permit(:bussiness_name, :rfc, :fiscalable_type, :fiscalable_id,
        	addresses_attributes: [:id, :name, :street, :outdoor_number, 
        		:interior_number, :cp, :references, :neighborhood, :phone, 
        		:country_id, :state_id, :fiscalcrosses, :locality, :fiscal, 
        		:crosses, :_destroy]
        )
      end

      def set_object
        @fiscal = Fiscal.find(params[:id])
      end

      def set_client
      	@client = Client.find(params[:client_id])
      end
  end
end