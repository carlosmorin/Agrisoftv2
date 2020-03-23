module Admin
  class UsersController < ApplicationController
    
    def index
    	@object_collection = User.all
    end
  end
end