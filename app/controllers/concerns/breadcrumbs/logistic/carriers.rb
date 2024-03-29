# frozen_string_literal: true

module Breadcrumbs::Logistic
  module Carriers
    extend ActiveSupport::Concern

    included do
      add_breadcrumb 'Logistica', :logistic_root_path
      add_breadcrumb 'Transportistas', :logistic_carriers_path
    end

    def build_breadcrumbs
      add_breadcrumb t("breadcrumbs.#{action_name}")
    end
  end
end
