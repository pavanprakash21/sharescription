# frozen_string_literal: true

class ShareRecord < ApplicationRecord
  extend Enumerize

  belongs_to :user
  belongs_to :medical_record
  belongs_to :shareable, polymorphic: true

  has_many :notifications, dependent: :destroy

  validates :medical_record_id, uniqueness: { scope: %i[shareable_id shareable_type] }

  enumerize :action, in: %i[requested granted shared], scope: true, predicates: true

  scope :doctor_records, -> { where(shareable_type: 'Doctor') }
  scope :pharma_records, -> { where(shareable_type: 'Pharmacist') }
  scope :permitted,      -> { where(shared: true) }
  scope :unpermitted,      -> { where(shared: false) }

  def self.shared_with(resource)
    where(shareable_type: resource.class.name, shareable_id: resource.id)
  end

  def safe_toggle(attr)
    public_send(attr) == true ? update(:"#{attr}" => false) : update(:"#{attr}" => true)
  end
end
