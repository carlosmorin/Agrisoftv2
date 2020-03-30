module Admin
  class UsersController < ApplicationController
    layout 'admin'
    before_action :set_object, only: %i[show edit update destroy]

    def index
    	@object_collection = User.all
    end

  	def new
      @object = User.new
      respond_to do |format|
        format.html
        format.js
      end
    end

	  def show; end
	  def edit; end

	  def create
	    @object = User.new(object_params)
      
      respond_to do |format|
        if @object.save
          format.html { redirect_to @object.post, notice: 'Comment was successfully created.' }
          format.js   { }
          format.json { render :show, status: :created, location: @comment }
        else
          format.html { render :new }
          format.json { render json: @object.errors, status: :unprocessable_entity }
        end
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
    	@object = User.find(params[:id])
  	end

    def object_params
    	params.require(:user).permit( :name, :last_name, :email, :password, :password_confirmation)
  	end
  end
end