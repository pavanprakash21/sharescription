# frozen_string_literal: true

class Pharmacist < ApplicationRecord
  validates :email, :name, presence: true
  validates :email, uniqueness: {  case_sensitive: false }
  validates :name, format: { with: /\A[a-zA-Z. ]*\z/, message: 'please use only English alphabets' },
                   length: { in: 4..60 }

  has_many :share_records, as: :shareable, dependent: :destroy
  has_many :sent_notifications, as: :sender, class_name: 'Notification', dependent: :destroy
  has_many :received_notifications, as: :recepient, class_name: 'Notification', dependent: :destroy

  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
