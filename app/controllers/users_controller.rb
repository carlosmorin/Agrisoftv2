class UsersController < ApplicationController
  before_action :set_object, only: %i[show edit update destroy]

  def index
    @object_collection = User.all
    search if params[:search].present?
  end

  def new
    @object = User.new
    render :new
  end

  def edit
  end

  def change_password
    @object = User.find(params[:user_id])
  end

  def create
    @object = User.new(object_params)

    respond_to do |format|
      if @object.save
        format.html { redirect_to users_url, notice: 'User was created.' }
        format.json { render :show, status: :created, location: @object }
      else
        format.html { render :new }
        format.json { render json: @object.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @object.update_attributes(object_params)
      flash[:notice] = 'User updated'
      redirect_to :action => "show", :id => @object.id
    else
      flash[:error] = 'Ocurrió un error.'
      render :new
    end
  end

  def destroy
    @object.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_object
    @object = User.find(params[:id])
  end

  def search
    s = Regexp.escape(params[:search])
    
    @object_collection = @object_collection.where("concat(name, ' ', last_name, ' ', email) ~* ?", s)
  end

  def object_params
    params.require(:user).permit(
      :email,:name, :last_name, :phone
    )
  end

end
