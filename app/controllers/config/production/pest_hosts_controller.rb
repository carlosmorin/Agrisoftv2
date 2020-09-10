class Config::Production::PestsController < ApplicationController
  before_action :find_host, only: %i[show edit destroy update]
  before_action :set_pest, only: %i[new update]

  add_breadcrumb "Produccion", :config_production_root_path
  add_breadcrumb "Hospederas", :config_production_hosts_path

  def create
    @host = Host.new(host_params)
    if @host.save
      flash[:notice] = "Hospedera creada correctamente"
      redirect_to config_production_pest_url(@pest, tab: :hosts)
    else
      render :new
    end
  end

  def new
    add_breadcrumb "Nuevo"
    @host = Host.new

  end

  def edit
    add_breadcrumb "Editar"
  end

  def update
    if @host.update(host_params)
      flash[:notice] = "La hospedera fue actualizada correctamente."
      redirect_to config_production_pest_url(@pest, tab: :hosts)
    else
      render :edit
    end
  end

  private

  def host_params
    params.require(:pest).permit(:name, :description, :picture,
      pests_hosts_attributes: [:id, :host_id, :pest_id, :_destroy])
  end

  def find_host
    @host = Host.find(params[:id])
  end

  def set_pest
    @pest = Pest.find(params[:pest_id]) if params[:pest_id].present?
  end
end