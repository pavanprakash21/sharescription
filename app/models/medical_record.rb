# frozen_string_literal: true

class MedicalRecord < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :user_id, case_insensitive: false }, length: { in: 3..60 }

  belongs_to :user
  has_many :prescriptions, dependent: :destroy, inverse_of: :medical_record

  accepts_nested_attributes_for :prescriptions, reject_if: :all_blank, allow_destroy: true
end
