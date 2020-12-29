# frozen_string_literal: true

module Crm
  module Config
    class MainController < ApplicationController
      add_breadcrumb 'CRM', :crm_root_path
      add_breadcrumb 'Configuración', :crm_config_root_path

      def index; end
    end
  end
end
