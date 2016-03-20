class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  def current_user
    user = super || User::Guest.new
    user.decorate
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :login
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(User::Salesman)
      sales_url
    else
      orders_url
    end
  end
end
