class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :update_allowed_parameters, if: :devise_controller?
  include Pagy::Backend
  protected

  def after_update_path_for(resource)
    user_path(resource)
  end

  def after_sending_reset_password_instructions_path_for(resource_name)
    puts "SENT!"
    root_path
  end

  def after_resetting_password_path_for(resource)
    root_path
  end

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :username, :email, :password, :password_confirmation, :current_password)}
  end

  def after_sign_in_path_for(resource)
     reviews_path
  end

end