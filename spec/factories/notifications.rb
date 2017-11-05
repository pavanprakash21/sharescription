# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id                :uuid             not null, primary key
#  sender_type       :string
#  sender_id         :uuid
#  recepient_type    :string
#  recepient_id      :uuid
#  action            :string           default(NULL), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  medical_record_id :uuid
#  share_record_id   :uuid
#

FactoryBot.define do
  factory :notification do
    sender
    recepient
    medical_record
    share_record
    action 'shared'
  end
end
