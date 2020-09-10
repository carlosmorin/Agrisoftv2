class Config::Production::DamagesController < ApplicationController
  before_action :find_damage, only: %i[show edit destroy update]
  before_action :set_pest_desease, only: %i[new update create]
  before_action :build_objects, only: %i[new edit]

  add_breadcrumb "Produccion", :config_production_root_path
  add_breadcrumb "Daños", :config_production_damages_path

  def index
    @index_facade = Damages::IndexFacade.new(params)
  end

  def create
    @damage = Damage.new(damage_params)
    if @damage.save
      @pest.pests_damages.create(damage_id: @damage.id) if @pest.present?
      @desease.deseases_damages.create(damage_id: @damage.id) if @desease.present?
      flash[:notice] = "Daño creado correctamente"
      get_redirect
    else
      if @pest.present?
        flash[:alert] = "#{PestDecorator.new(@pest).display_errors}"
        return redirect_to new_config_production_pest_damage_path(params[:pest_id])
      elsif @desease.present?
        flash[:alert] = "#{DeseaseDecorator.new(@desease).display_errors}"
        return redirect_to new_config_production_desease_damage_path(params[:desease_id])
      end
      render_errors
      render :new
    end
  end

  def new
    add_breadcrumb "Nuevo"
  end

  def edit
    add_breadcrumb "Editar"
  end

  def show
    add_breadcrumb "Detalle de el Daño"
  end

  def update
    if @damage.update(damage_params)
      flash[:notice] = "El Daño fue actualizado correctamente."
      get_redirect
    else
      render_errors
      render :edit
    end
  end

  def destroy
    @damage.destroy
  end

  private

  def get_redirect
    return redirect_to config_production_pest_path(@pest, tab: :damages) if @pest.present?
    return redirect_to config_production_desease_path(@desease, tab: :damages) if @desease.present?
    redirect_to config_production_damage_url(@damage, tab: :general)
  end

  def render_errors
    render_errors = @damage.errors.full_messages.join(', ').include?("Pests") || @damage.errors.full_messages.join(', ').include?("Deseases")
    flash[:alert] = "Elimina selects adicionales si no deseas agregar plagas o enfermedades." if render_errors 
  end

  def build_objects
    @damage = Damage.new if @damage.nil?
    @damage.pests_damages.build
    @damage.deseases_damages.build
  end

  def damage_params
    params.require(:damage).permit(:name, :description, :picture, :pest_id, :desease_id,
      pests_damages_attributes: [:id, :damage_id, :pest_id, :_destroy],
      deseases_damages_attributes: [:id, :damage_id, :desease_id, :_destroy])
  end

  def find_damage
    @damage = Damage.find(params[:id])
  end

  def set_pest_desease
    @pest = Pest.find(params[:pest_id]) if params[:pest_id].present?
    @desease = Desease.find(params[:desease_id]) if params[:desease_id].present?
  end

end