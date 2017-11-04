# frozen_string_literal: true

class ShareRecordsController < ApplicationController
  skip_before_action :verify_authenticity_token, if: :json_request?, only: :create

  def index
    @share_records = current_user.share_records.order(created_at: :desc)
  end

  def create
    share_record = current_user.share_records.new(share_record_params)
    if share_record.save
      respond_to do |format|
        format.json { render json: { message: 'Record has been successfully shared' }, status: 200 }
      end
    else
      respond_to do |format|
        format.json do
          render json: { errors: share_record.errors, message: 'This record has already been shared' }, status: 400
        end
      end
    end
  end

  private

  def share_record_params
    params.require(:share_record).permit(:medical_record_id, :shareable_id, :shareable_type)
  end

  def json_request?
    request.format.json?
  end
end
