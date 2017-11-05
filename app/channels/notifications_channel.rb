# frozen_string_literal: true

class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications_#{current_user.class.name.downcase}_#{current_user.id}"
    logger.add_tags 'NotificationsChannel', current_user.name
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
