# frozen_string_literal: true

class MedicalRecordsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  before_action :find_medical_record, only: %i[edit update destroy]

  def index
    @medical_records = if user_signed_in?
                         current_user.medical_records.order(created_at: :desc)
                       else
                         'Sorry not allowed'
                       end
  end

  def dorp_index
    @user = User.find(params[:user_id])
    @medical_records = MedicalRecord.where(user: @user)
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
        format.html { redirect_to medical_records_path, success: 'Your medical record has been saved' }
      end
    else
      respond_to do |format|
        format.html { render :new }
      end
    end
  end

  def show
    @medical_record = if current_user
                        current_user.medical_records.find(params[:id])
                      else
                        MedicalRecord.find(params[:id])
                      end
  end

  def edit; end

  def update
    respond_to do |format|
      if @medical_record.update(medical_record_params)
        format.html { redirect_to medical_records_path, success: 'Your medical record has been updated' }
      else
        format.html { render :edit, notice: 'Your medical record has not been updated' }
      end
    end
  end

  def destroy
    @medical_record.destroy
    respond_to do |format|
      format.html { redirect_to medical_records_path, notice: 'Your medical record has been updated' }
    end
  end

  private

  def find_medical_record
    @medical_record = current_user.medical_records.find(params[:id])
  end

  def medical_record_params
    params.require(:medical_record).permit(:name, :notes,
      prescriptions_attributes: %i[id name dosage dosage_unit morning afternoon night time _destroy])
  end
end
