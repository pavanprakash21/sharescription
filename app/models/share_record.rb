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

class ShareRecord < ApplicationRecord
  extend Enumerize

  belongs_to :user
  belongs_to :medical_record
  belongs_to :shareable, polymorphic: true

  has_many :notifications, dependent: :destroy

  validates :medical_record_id, uniqueness: { scope: %i[shareable_id shareable_type] }

  enumerize :action, in: %i[requested_to granted_to shared], scope: true, predicates: true

  scope :doctor_records, -> { where(shareable_type: 'Doctor') }
  scope :pharma_records, -> { where(shareable_type: 'Pharmacist') }
  scope :permitted,      -> { where(shared: true) }
  scope :unpermitted,      -> { where(shared: false) }

  # Creates from a shareable resource. Used in the observer as an after create
  def self.shared_with(resource)
    where(shareable_type: resource.class.name, shareable_id: resource.id)
  end

  # Toggles between true and false. Use this instead of #toggle as #toggle doesn't validate record
  def safe_toggle(attr)
    public_send(attr) == true ? update(:"#{attr}" => false) : update(:"#{attr}" => true)
  end
end
