# frozen_string_literal: true

module Logistic
  class ContactsController < ApplicationController
    include Breadcrumbs::Logistic::Contacts

    before_action :set_object, only: %i[show edit update destroy]
    before_action :set_carrier, only: %i[new edit show]
    before_action :build_breadcrumbs, only: %i[new edit show]

    def new
      @contact = Contact.new
    end

    def edit; end

    def show; end

    def create
      @contact = Contact.new(contact_params)
      if @contact.save
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Contacto registrado correctamente"
        redirect_to logistic_carrier_path(@contact.contactable, tab: :contacts)
      else
        set_carrier
        build_breadcrumbs
        render :new
      end
    end

    def update
      if @contact.update(contact_params)
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Contacto actualizado correctamente"
        redirect_to logistic_carrier_path(@contact.contactable, tab: :contacts)
      else
        set_carrier
        build_breadcrumbs
        render :edit
      end
    end

    private

    def contact_params
      params.require(:contact).permit(:name, :last_name, :email, :phone,
                                      :mobile_phone, :position, :alias, :comments, :contactable_type, :contactable_id)
    end

    def set_object
      @contact = Contact.find(params[:id])
    end
  end
end
