# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    sender
    recepient
    action 'shared'
  end
end
