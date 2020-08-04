module Crm
  class ContractsController < ApplicationController

		def new
			@contract = Contract.new(client_id: params[:client_id])
		end

		def create
			@contact = Contact.new(contact_params)
			if @contact.save
				flash[:notice] =  "<i class='fa fa-check-circle mr-1 s-18'></i> Contacto registrado correctamente"
				redirect_to crm_client_path(@contact.contactable, tab: :contacts) 
			else
				set_client
				set_breadcrumb
				render :new
			end
    end

		def update
      if @contact.update(contact_params)
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Contacto actualizado correctamente"
        redirect_to crm_client_path(@contact.contactable, tab: :contacts) 
      else
				set_client
				set_breadcrumb
        render :edit
      end
    end

		private

		def contact_params
			params.require(:contact).permit(:name, :last_name, :email, :phone, 
				:mobile_phone, :position, :alias, :contactable_type, :contactable_id)
		end

		def set_object
			@contact = Contact.find(params[:id])
		end
	end
end