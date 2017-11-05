# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Create the current_resource helper to easily identify who has logged in instead of using if else everywhere
  def current_resource
    if user_signed_in?
      current_user
    elsif doctor_signed_in?
      current_doctor
    elsif pharmacist_signed_in?
      current_pharmacist
    end
  end

  # Similar to current_resource, use this to authenticate
  def authenticate!
    if user_signed_in?
      authenticate_user!
    elsif doctor_signed_in?
      authenticate_doctor!
    elsif pharmacist_signed_in?
      authenticate_pharmacist!
    else
      redirect_to root_path, alert: 'Access Restricted'
    end
  end

  protected

  # Add this to permit extra attrs while signing up.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
