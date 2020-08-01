module Commercial
	module Config
		class MainController < ApplicationController
			def index
				add_breadcrumb "Commercial", :commercial_root_path
	      add_breadcrumb "Configuración", :commercial_config_root_path
			end
		end
	end
end