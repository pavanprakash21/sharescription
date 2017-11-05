# frozen_string_literal: true

class Notification < ApplicationRecord
  extend Enumerize

  belongs_to :sender, polymorphic: true
  belongs_to :recepient, polymorphic: true

  validates :action, presence: true

  enumerize :action, in: %i[requested granted shared], scope: true, predicates: true
end
