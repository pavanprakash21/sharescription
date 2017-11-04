# frozen_string_literal: true

module ShareRecordsHelper
  def visibility_icon(record)
    record.shared? ? 'visibility' : 'visibility_off'
  end
end
