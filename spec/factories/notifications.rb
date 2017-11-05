# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    sender
    recepient
    medical_record
    action 'shared'
  end
end
