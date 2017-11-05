# frozen_string_literal: true

class NotificationWorker
  include Sidekiq::Worker

  def perform(note_id)
    note = Notification.find(note_id)
    current_user = note.recepient
    ActionCable.server.broadcast "notifications_#{current_user.class.name.downcase}_#{current_user.id}", send_data(note)
  end

  private

  def send_data(note)
    {
      sender_type: note.sender_type, sender_id: note.sender_id,
      recepient_type: note.recepient_type, recepient_id: note.recepient_id,
      action: note.action, medical_record_id: note.medical_record_id
    }
  end
end
