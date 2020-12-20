# frozen_string_literal: true

module Breadcrumbs::Logistic::Config
  module BoxTypes
    extend ActiveSupport::Concern

    included do
      add_breadcrumb 'Logistica', :logistic_root_path
      add_breadcrumb 'Configuración', :logistic_config_root_path
      add_breadcrumb 'Tipos de Cajas', :logistic_config_box_types_path
    end

    def build_breadcrumbs
      add_breadcrumb t("breadcrumbs.#{action_name}")
    end
  end
end
