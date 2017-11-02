# frozen_string_literal: true

FactoryBot.define do
  factory :medical_record do
    name { Faker::GameOfThrones.character }
    notes { Faker::Hobbit.quote }
    user
  end
end
