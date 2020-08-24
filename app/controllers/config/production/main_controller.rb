module Config::Production
  class MainController < ApplicationController
    add_breadcrumb "Produccion", :config_production_root_path
    def index; end
  end
end