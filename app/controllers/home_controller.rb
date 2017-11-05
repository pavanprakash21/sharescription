# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    if user_signed_in?
      total_medical_records = current_user.medical_records.size
      total_presriptions = current_user.prescriptions.size
      total_doctor_shared_records = current_user.share_records.doctor_records.size
      total_pharma_shared_records = current_user.share_records.pharma_records.size

      @data = {
        total_medical_records:       total_medical_records,
        total_presriptions:          total_presriptions,
        total_doctor_shared_records: total_doctor_shared_records,
        total_pharma_shared_records: total_pharma_shared_records
      }

      @notifications = current_user.received_notifications.includes(:sender, :medical_record)
                                   .order(created_at: :desc)
    end
  else
    #
  end
end
