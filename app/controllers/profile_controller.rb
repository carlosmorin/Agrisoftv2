class ProfileController < ApplicationController
  before_action :set_object, only: %i[show avtar update change_password]
  add_breadcrumb "Perfil", :profile_index_path

	def index
	end

	def show
	end

	def avatar
    add_breadcrumb "Actualizar avatar"
	end

  def change_password
    add_breadcrumb "Actualizar contraseña"
  end

	def update
    if @user.update_attributes(object_params)
			flash[:notice] = "<i class='fa fa-check-circle mr-1 s-18'></i> Perfil actualizado exitosamente"
      redirect_to profile_index_path
    else
      return render :change_password if @user.password.present?
      return render :avatar if @user.avatar.present?
    end
  end

  private 
 	
 	def set_object
 		id = params[:id].present? ? params[:id] : params[:profile_id]
 		@user = User.find(id)
 	end

 	def object_params
    params.require(:user).permit(:avatar, :password, :password_confirmation)
  end
end