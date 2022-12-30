class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Modify application_controller.rb and add
  # username, email, password, password confirmation
  # and remember me to configure_permitted_parameters
  def configure_permitted_parameters
    added_attrs = %i[username email password password_confirmation remember_me avatar]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: %i[login password]
    devise_parameter_sanitizer.permit :account_update, keys: [added_attrs, :bio]
  end
end
