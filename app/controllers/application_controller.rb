class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	add_breadcrumb 'Inicio', :root_path
end
