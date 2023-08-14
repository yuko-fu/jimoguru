class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  # skip_before_action :authenticate_user!
  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path, alert: '画面を閲覧する権限がありません。'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :prefecture])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :prefecture])
  end
end
