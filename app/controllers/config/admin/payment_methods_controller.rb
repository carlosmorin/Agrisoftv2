module Config
	class paymentMethodsController < ApplicationController
		before_action :set_object, only: %i[edit update destroy]
		add_breadcrumb "Marcas", :config_client_brands_path
	end
end