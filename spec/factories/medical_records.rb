# frozen_string_literal: true

# == Schema Information
#
# Table name: medical_records
#
#  id                  :uuid             not null, primary key
#  name                :string           default(""), not null
#  notes               :text
#  user_id             :uuid
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  prescriptions_count :integer          default(0), not null
#

FactoryBot.define do
  factory :medical_record do
    name { Faker::GameOfThrones.character }
    notes { Faker::Hobbit.quote }
    user
  end
end
