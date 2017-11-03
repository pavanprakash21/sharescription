# frozen_string_literal: true

class ShareRecordsController < ApplicationController
  def index
    @share_records = current_user.share_records.order(created_at: :desc)
  end

  def create; end
end
