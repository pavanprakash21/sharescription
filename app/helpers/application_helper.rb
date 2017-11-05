# frozen_string_literal: true

module ApplicationHelper
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
