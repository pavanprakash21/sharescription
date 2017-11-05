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

class Prescription < ApplicationRecord
  extend Enumerize

  validates :name, :dosage, :dosage_unit, :time, presence: true
  validates :name, uniqueness: { scope: :medical_record_id, case_insensitive: false }, length: { in: 3..100 }

  belongs_to :medical_record, counter_cache: true

  enumerize :dosage_unit, in: %i[tablet ml mg tablespoon sachet], scope: true, predicates: true, default: :tablet
  enumerize :time, in: %i[before_food after_food], scope: true, predicates: true, default: :after_food
end
