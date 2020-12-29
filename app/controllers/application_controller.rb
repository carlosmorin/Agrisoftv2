# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # before_action :save_activity!
  add_breadcrumb 'Inicio', :root_path

  private

  def save_activity!
    return unless current_user.present?

    url = request.url
    action = action_name
    ip = request.remote_ip
    Activity.create(
      user_id: current_user.id,
      url: request.url,
      action: action_name,
      ip_address: request.remote_ip
    )
  end
end
