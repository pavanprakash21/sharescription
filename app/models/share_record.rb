# frozen_string_literal: true

class ShareRecord < ApplicationRecord
  belongs_to :user
  belongs_to :medical_record
  belongs_to :shareable, polymorphic: true
end
