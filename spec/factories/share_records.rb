# frozen_string_literal: true

# == Schema Information
#
# Table name: share_records
#
#  id                :uuid             not null, primary key
#  shared            :boolean          default(FALSE), not null
#  user_id           :uuid
#  medical_record_id :uuid
#  shareable_type    :string
#  shareable_id      :uuid
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  created_by        :string
#  action            :string
#

FactoryBot.define do
  factory :share_record do
    shared false
    user
    medical_record
    action :requested
    association :shareable, factory: :doctor

    trait :shared do
      shared true
    end

    trait :unshared do
      shared false
    end

    trait :shared_with_doctor do
      shared true
      association :shareable, factory: :doctor
    end

    trait :shared_with_pharmacist do
      shared true
      association :shareable, factory: :pharmacist
    end

    trait :unshared_with_doctor do
      shared false
      association :shareable, factory: :doctor
    end

    trait :unshared_with_pharmacist do
      shared false
      association :shareable, factory: :pharmacist
    end
  end
end
