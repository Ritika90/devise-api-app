class ApplicationController < ActionController::API
  before_filter :configure_permitted_parameters, if: :devise_controller?
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation, :authentication_token)
    end
  end
include ActionController::MimeResponds
end



