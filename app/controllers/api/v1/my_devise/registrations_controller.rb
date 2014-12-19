class Api::V1::MyDevise::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters
  def create
    binding.pry
    build_resource(sign_up_params)
    resource_saved = resource.save
    yield resource if block_given?
    binding.pry
    if resource_saved
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
         render :json => {:user => {:email => current_user.email, :authentication_token => resource.authentication_token, :status => "User Created & Signed_In"}}
      else
        expire_data_after_sign_in!
        render :json => {:user => {:email => current_user.email, :status => false}}
      end
    else
      render :json => {:status => false}
    end

  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.sanitize(:sign_up) { |u|
      u.permit(:email, :password, :password_confirmation, :authentication_token)
    }
  end
end

