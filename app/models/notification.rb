# frozen_string_literal: true

class Notification < ApplicationRecord
  extend Enumerize

  belongs_to :sender, polymorphic: true
  belongs_to :recepient, polymorphic: true

  validates :action, presence: true

  enumerize :action, in: %i[requested granted shared], scope: true, predicates: true

  def self.create_from(share_record, action)
    create!(sender: share_record.user, recepient: share_record.shareable, action: action,
      medical_record_id: share_record.medical_record.id)
  end
end
