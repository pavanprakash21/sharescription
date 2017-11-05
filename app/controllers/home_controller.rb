# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    user_data if user_signed_in?
    dorp_data if doctor_signed_in? || pharmacist_signed_in?
    @notifications = current_resource.received_notifications.includes(:sender, :medical_record, :share_record)
                                     .order(created_at: :desc).limit(20)
  end

  private

  def user_data
    total_medical_records = current_resource.medical_records.size
    total_presriptions = current_resource.prescriptions.size
    total_doctor_shared_records = current_resource.share_records.doctor_records.size
    total_pharma_shared_records = current_resource.share_records.pharma_records.size

    @data = {
      total_medical_records:           total_medical_records,
      total_presriptions:              total_presriptions,
      shared_records_with_doctor:      total_doctor_shared_records,
      shared_records_with_pharmacists: total_pharma_shared_records
    }
  end

  def dorp_data
    total_permitted_records = current_resource.share_records.permitted.size
    total_shared_records = current_resource.share_records.size
    total_number_of_users = User.count
    total_unpermitted_records = current_resource.share_records.unpermitted.size
    @data = {
      total_shared_records:      total_shared_records,
      total_number_of_users:     total_number_of_users,
      total_permitted_records:   total_permitted_records,
      total_unpermitted_records: total_unpermitted_records
    }.sort
  end
end
