class UsersController < ApplicationController
	def index
    @object_collection = User.all
  end

  def prro
  	@hola = "K onda prro?"
  end
end
