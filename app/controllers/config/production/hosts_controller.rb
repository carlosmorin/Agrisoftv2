# frozen_string_literal: true

class Config::Production::HostsController < ApplicationController
  before_action :find_host, only: %i[show edit destroy update]
  before_action :set_pest_desease, only: %i[new update create]
  before_action :build_objects, only: %i[new edit]

  add_breadcrumb 'Produccion', :config_production_root_path
  add_breadcrumb 'Hospederas', :config_production_hosts_path

  def index
    @index_facade = Hosts::IndexFacade.new(params)
  end

  def create
    @host = Host.new(host_params)
    if @host.save
      @pest.pests_hosts.create(host_id: @host.id) if @pest.present?
      @desease.deseases_hosts.create(host_id: @host.id) if @desease.present?
      flash[:notice] = 'Hospedera creada correctamente'
      get_redirect
    else
      if @pest.present?
        flash[:alert] = PestDecorator.new(@pest).display_errors.to_s
        return redirect_to new_config_production_pest_host_path(params[:pest_id])
      elsif @desease.present?
        flash[:alert] = DeseaseDecorator.new(@desease).display_errors.to_s
        return redirect_to new_config_production_desease_host_path(params[:desease_id])
      end
      render :new
    end
  end

  def new
    add_breadcrumb 'Nuevo'
  end

  def edit
    add_breadcrumb 'Editar'
  end

  def show
    add_breadcrumb 'Detalle de la Hospedera'
  end

  def update
    if @host.update(host_params)
      flash[:notice] = 'La hospedera fue actualizada correctamente.'
      get_redirect
    else
      render_errors = @host.errors.full_messages.join(', ').include?('Pests') || @host.errors.full_messages.join(', ').include?('Deseases')
      if render_errors
        flash[:alert] = 'Elimina selects adicionales si no deseas agregar plagas o enfermedades.'
      end
      render :edit
    end
  end

  def destroy
    @host.destroy
  end

  private

  def get_redirect
    if @pest.present?
      return redirect_to config_production_pest_path(@pest, tab: :hosts)
    end
    if @desease.present?
      return redirect_to config_production_desease_path(@desease, tab: :hosts)
    end

    redirect_to config_production_host_url(@host, tab: :general)
  end

  def build_objects
    @host = Host.new if @host.nil?
    @host.pests_hosts.build
    @host.deseases_hosts.build
  end

  def host_params
    params.require(:host).permit(:name, :description, :picture, :pest_id, :desease_id,
                                 pests_hosts_attributes: %i[id host_id pest_id _destroy],
                                 deseases_hosts_attributes: %i[id host_id desease_id _destroy])
  end

  def find_host
    @host = Host.find(params[:id])
  end

  def set_pest_desease
    @pest = Pest.find(params[:pest_id]) if params[:pest_id].present?
    @desease = Desease.find(params[:desease_id]) if params[:desease_id].present?
  end
end
