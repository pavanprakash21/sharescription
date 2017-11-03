# frozen_string_literal: true

FactoryBot.define do
  factory :prescription do
    name { Faker::Space.star_cluster }
    dosage { Faker::Number.between(1, 5) }
    dosage_unit { %w[ml tablespoon tablet mg sachet].sample }
    morning false
    afternoon false
    night true
    time { %w[before_food after_food].sample }
    medical_record
  end
end
