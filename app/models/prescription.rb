# frozen_string_literal: true

class Prescription < ApplicationRecord
  validates :name, :dosage, :dosage_unit, :time, presence: true
  validates :name, uniqueness: { scope: :medical_record_id, case_insensitive: false }, length: { in: 3..100 }

  belongs_to :medical_record
end
