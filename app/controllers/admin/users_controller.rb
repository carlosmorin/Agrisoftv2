# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    layout 'admin'
    before_action :set_object, only: %i[show edit update destroy]
    before_action :index, only: %i[update]

    def index
      @users = User.paginate(page: params[:page], per_page: 15)
      search if params[:q].present?
    end

    def new
      @user = User.new
      respond_to do |format|
        format.html
        format.js
      end
    end

    def show; end

    def edit; end

    def create
      @user = User.new(object_params)

      respond_to do |format|
        if @user.save
          format.js
          format.json { render @user, status: :created }
        else
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @user.update_attributes(object_params)
          format.js
          format.json { render @users, status: :updated }
        else
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @user.destroy
    end

    private

    def search
      q = Regexp.escape(params[:q])

      @users = @users.where("concat(name, ' ', last_name, ' ', email) ~* ?", q)
    end

    def set_object
      @user = User.find(params[:id])
   end

    def object_params
      params.require(:user).permit(:name, :last_name, :email, :password, :password_confirmation)
    end
  end
end
