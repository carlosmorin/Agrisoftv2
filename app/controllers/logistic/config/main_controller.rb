# frozen_string_literal: true

module Logistic
  module Config
    class MainController < ApplicationController
      def index
        add_breadcrumb 'Logistica', :logistic_root_path
        add_breadcrumb 'Configuración', :logistic_config_root_path
      end
    end
  end
end
