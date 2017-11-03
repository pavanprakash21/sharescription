# frozen_string_literal: true

class Prescription < ApplicationRecord
  extend Enumerize

  validates :name, :dosage, :dosage_unit, :time, presence: true
  validates :name, uniqueness: { scope: :medical_record_id, case_insensitive: false }, length: { in: 3..100 }

  belongs_to :medical_record

  enumerize :dosage_unit, in: %i[tablet ml mg tablespoon sachet], scope: true, predicates: true, default: :tablet
  enumerize :time, in: %i[before_food after_food], scope: true, predicates: true, default: :after_food
end
