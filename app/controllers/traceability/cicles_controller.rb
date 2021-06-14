# frozen_string_literal: true

module Traceability
  class CiclesController < ApplicationController
    before_action :set_object, only: %i[show edit update update_status]
    before_action :set_collections, only: %i[new edit]

    def index
      @cicles = Cicle.all.order(:created_at)
      filter_by_query if params[:query]
      @cicles = @cicles.paginate(page: params[:page], per_page: 16)
    end

    def new
      @cicle = Cicle.new
    end

    def create
      @cicle = Cicle.new(cicle_params)
      if @cicle.save
        flash[:notice] = "<i class='fa fa-check-circle mr-2'></i> Ciclo creada exitosamente"
        redirect_to traceability_cicle_path(@cicle)
      else
        set_collections
        render :new
      end
    end

    def update
      if @cicle.update(cicle_params)
        flash[:notice] = "<i class='fa fa-check-circle mr-2'></i> Ciclo actualizado"
        redirect_to traceability_cicle_path(@cicle)
      else
        set_collections
        render :edit
      end
    end

    def update_status
      @cicle.update(status: :active)
      update_areas
      redirect_to traceability_cicle_path(@cicle)
    end

    private

    def update_areas
      @cicle.cicles_areas.update_all(status: :busy)
      create_cicles_areas_log
    end

    def create_cicles_areas_log
      @cicle.cicles_areas.each do |ca|
        crop_name = ca.cicle.crop.name.upcase
        area_name = ca.area.name.upcase
        ca_name = ca.name.upcase

        ca.cicles_areas_logs.new(cicles_area_id: ca.id, name: "#{crop_name}-#{area_name}-#{ca_name}").save!
      end
    end

    def filter_by_query
      query = Regexp.escape(params[:query])

      @cicles = @cicles.where("name ~* ?", query)
    end

    def set_collections
      @areas = Area.all.pluck(:name, :id)
    end

    def set_object
      id = params[:id].present? ? params[:id] : params[:cicle_id]

      @cicle = Cicle.find(id)
    end

    def cicle_params
      params.require(:cicle).permit(:id, :name, :crop_id, :ranch_id, 
        cicles_areas_attributes: %i[id cicle_id area_id started_at finished_at 
          status name busy_porcent _destroy]
      )
    end
  end
end
