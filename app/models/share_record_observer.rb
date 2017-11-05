# frozen_string_literal: true

class ShareRecordObserver < ActiveRecord::Observer
  def after_save(share_record)
    if created_by_user(share_record)
      Notification.create_from(share_record)
    elsif created_by_dorp(share_record)
      Notification.create_from(share_record)
    end
  end

  private

  def created_by_user(share_record)
    share_record.created_by == 'User'
  end

  def created_by_dorp(share_record)
    share_record.created_by == 'Doctor' || share_record.created_by == 'Pharmacist'
  end
end
