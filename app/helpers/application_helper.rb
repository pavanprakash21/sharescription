# frozen_string_literal: true

module ApplicationHelper
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
end
