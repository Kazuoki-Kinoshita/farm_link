class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role])
  end

  def ensure_profile_exists
    if current_user.farmer? && current_user.farmer.nil?
      redirect_to new_farmer_path, alert: "プロフィール登録をお願いします"
    elsif current_user.general? && current_user.general.nil?
      redirect_to new_general_path, alert: "プロフィール登録をお願いします"
    end
  end
end