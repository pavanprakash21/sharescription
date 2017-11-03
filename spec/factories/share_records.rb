# frozen_string_literal: true

FactoryBot.define do
  factory :share_record do
    shared false
    user
    medical_record
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
