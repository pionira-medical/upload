class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    order_path(current_user.order) if current_user.present?
    admin_dashboard_path if current_admin_user.present?
  end
end
