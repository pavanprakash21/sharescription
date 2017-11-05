# frozen_string_literal: true

# == Schema Information
#
# Table name: prescriptions
#
#  id                :uuid             not null, primary key
#  name              :string           default(""), not null
#  dosage            :string           default(""), not null
#  dosage_unit       :string           default(NULL), not null
#  morning           :boolean          default(FALSE), not null
#  afternoon         :boolean          default(FALSE), not null
#  night             :boolean          default(FALSE), not null
#  time              :string           default(NULL), not null
#  medical_record_id :uuid
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

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
