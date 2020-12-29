# frozen_string_literal: true

class Config::Production::PackagesController < ApplicationController
  before_action :set_object, only: %i[show edit update destroy]

  add_breadcrumb 'Produccion', :config_production_root_path
  add_breadcrumb 'Empaques', :config_production_packages_path

  def index
    @packages = Package.paginate(page: params[:page], per_page: 16)
    search if params[:q].present?
  end

  def new
    add_breadcrumb 'Nuevo'
    @package = Package.new
  end

  def edit
    add_breadcrumb 'Editar'
  end

  def show
    add_breadcrumb 'Detalle'
  end

  def create
    @package = Package.new(package_params)
    respond_to do |format|
      if @package.save
        format.html { redirect_to config_production_packages_url, notice: 'Empaque creado.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    if @package.update(package_params)
      flash[:notice] = "Tamaño #{@package.name} Actualizado"
      redirect_to config_production_packages_url
    else
      render :edit
    end
 end

  def destroy
    @package.destroy
  end

  private

  def search
    q = Regexp.escape(params[:q])

    @packages = @packages.where('name ~* ?', q)
  end

  def package_params
    params.require(:package).permit(:name)
  end

  def set_object
    @package = Package.find(params[:id])
  end
end
