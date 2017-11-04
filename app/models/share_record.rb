# frozen_string_literal: true

class ShareRecord < ApplicationRecord
  belongs_to :user
  belongs_to :medical_record
  belongs_to :shareable, polymorphic: true

  validates :medical_record_id, uniqueness: { scope: %i[shareable_id shareable_type] }

  def safe_toggle(attr)
    public_send(attr) == true ? update(:"#{attr}" => false) : update(:"#{attr}" => true)
  end
end
