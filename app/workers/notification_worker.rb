# frozen_string_literal: true

class NotificationWorker
  include Sidekiq::Worker

  def perform(*args)
    # Do something
  end
end
