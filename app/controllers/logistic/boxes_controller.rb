# frozen_string_literal: true

module Logistic
  class BoxesController < ApplicationController
    before_action :set_object, only: %i[show edit update destroy]
    before_action :set_catalogs, except: %i[show]

    def index
      @boxes = Box.paginate(page: params[:page], per_page: 16)

      search if params[:q].present?
      search_by_carrier if params[:c].present?
      search_by_box_type if params[:b_t].present?
     end

    def new
      carrier = Carrier.find(params[:carrier_id])
      add_breadcrumb 'Transportistas', logistic_carriers_path
      add_breadcrumb carrier.name.upcase, logistic_carriers_path
      add_breadcrumb 'Cajas', logistic_carrier_path(carrier, tab: :boxes)
      add_breadcrumb 'Nueva'
      @box = Box.new
    end

    def edit
      add_breadcrumb 'Transportistas', logistic_carriers_path
      add_breadcrumb @box.carrier.name.upcase, logistic_carriers_path
      add_breadcrumb 'Cajas', logistic_carrier_path(@box.carrier, tab: :boxes)
      add_breadcrumb @box.short_name.to_s, logistic_carrier_box_path(@box.carrier, @box)
      add_breadcrumb 'Editar'
     end

    def show
      add_breadcrumb 'Transportistas', logistic_carriers_path
      add_breadcrumb @box.carrier.name.upcase, logistic_carriers_path
      add_breadcrumb 'Cajas', logistic_carrier_path(@box.carrier, tab: :boxes)
      add_breadcrumb @box.short_name.to_s, logistic_carrier_box_path(@box.carrier, @box)
     end

    def create
      @box = Box.new(box_params)
      if @box.save
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Caja creada correctamente"
        redirect_to logistic_carrier_path(@box.carrier, tab: :boxes)
      else
        render :new, carriers: @carriers, box_types: @box_types
      end
     end

    def update
      if @box.update(box_params)
        flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Caja actualizada correctamente"
        redirect_to logistic_carrier_path(@box.carrier, tab: :boxes)
      else
        render :edit, carriers: @carriers, box_types: @box_types
      end
    end

    def destroy
      @box.destroy
     end

    private

    def search
      s = Regexp.escape(params[:q])

      @boxes = @boxes.where("concat(plate_number, ' ', n_econ) ~* ?", s)
    end

    def search_by_carrier
      c = Regexp.escape(params[:c])

      @boxes = @boxes.where(carrier_id: c)
    end

    def search_by_box_type
      b_t = Regexp.escape(params[:b_t])

      @boxes = @boxes.where(box_type_id: b_t)
    end

    def box_params
      params.require(:box).permit(
        :temperature, :plate_number, :n_econ, :carrier_id, :box_type_id
      )
    end

    def set_object
      @box = Box.find(params[:id])
     end

    def set_catalogs
      @carriers = Carrier.all.pluck(:name, :id)
      @box_types = BoxType.all.pluck(:name, :id)
     end
  end
end
