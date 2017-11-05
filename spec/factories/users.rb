# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: %i[sender recepient] do
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password(10, 20) }
    name { Faker::Name.name }
  end
end
