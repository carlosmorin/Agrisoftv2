module Admin
  class UsersController < ApplicationController
    layout 'admin'
    before_action :set_object, only: %i[show edit update destroy]

    def index
    	@object_collection = User.all
    end

  	def new
    	@user = User.find_or_initialize_by(id: params[:i]) 
      @gen_inf = GeneralInformation.find_or_initialize_by(id: params[:gi]) 
	  end

	  def show; end
	  def edit; end

	  def create
	    @user = User.new(object_params)

      if @user.save
        redirect_to new_admin_user_path(t: params[:next_step], o: @user.id)
      else
      	flash[:errors] = @user.errors.full_messages
        redirect_to new_admin_user_path(t: params[:current_step])
      end
	  end

    def update
      if @user.update_attributes(object_params)
        flash[:notice] = 'User updated'
        redirect_to :action => "show", :id => @object.id
      else
        flash[:error] = 'Ocurrió un error'
        render :new
      end
    end

    private
   	
    def create_general_information
      @object = GeneralInformation.new(general_information_params)

      if @object.save
        format.html { redirect_to users_url, notice: 'User was created.' }
        format.json { render :show, status: :created, location: @object }
      else
        flash[:errors] = @object.errors.full_messages
        redirect_to new_admin_user_path(t: params[:current_step])
      end
    end
   	def set_object
    	@user = User.find(params[:id])
  	end

    def object_params
    	params.require(:user).permit( :email, :password, :password_confirmation)
  	end

    def general_information_params
      params.require(:general_information).permit(
        :name, :last_name, :born_date, :alias, :level_studies, :school_name, :user_id)
    end
  end
end