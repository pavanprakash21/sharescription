# frozen_string_literal: true

class MedicalRecord < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :user_id, case_insensitive: false }, length: { in: 3..60 }

  belongs_to :user, counter_cache: true

  has_many :prescriptions, dependent: :destroy, inverse_of: :medical_record
  has_many :share_records, dependent: :destroy
  has_many :notifications, dependent: :destroy

  accepts_nested_attributes_for :prescriptions, reject_if: :all_blank, allow_destroy: true
end
