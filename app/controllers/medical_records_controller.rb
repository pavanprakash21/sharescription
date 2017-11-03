# frozen_string_literal: true

class MedicalRecordsController < ApplicationController
  before_action :find_medical_record, only: :show
  before_action :authenticate_user!, only: %i[new create]

  def index
    @medical_records = if user_signed_in?
                         current_user.medical_records.order(created_at: :desc)
                       else
                         'Sorry not allowed'
                       end
  end

  def new
    return unless user_signed_in?
    @medical_record = current_user.medical_records.new
    @prescription = @medical_record.prescriptions.build
  end

  def create
    @medical_record = current_user.medical_records.new(medical_record_params)
    if @medical_record.save
      respond_to do |format|
        format.html { redirect_to @medical_record, success: 'Your medical record has been saved' }
      end
    else
      respond_to do |format|
        format.html { render :new }
      end
    end
  end

  def show; end

  private

  def find_medical_record
    @medical_record = current_user.medical_records.find(params[:id])
  end

  def medical_record_params
    params.require(:medical_record).permit(:name, :notes,
      prescriptions_attributes: %i[id name dosage dosage_unit morning afternoon night time _destroy])
  end
end
