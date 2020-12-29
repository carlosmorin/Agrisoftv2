# frozen_string_literal: true

module Admin
  class AdminController < ApplicationController
    before_action :load_admin_layout!
    def load_admin_layout!
      respond_to do |format|
        format.html { render layout: 'admin' }
      end
    end
  end
end
