# frozen_string_literal: true

class ShareRecordObserver < ActiveRecord::Observer
  def after_save(share_record)
    Notification.create_from(share_record)
  end
end
