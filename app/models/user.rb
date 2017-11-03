# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, :name, presence: true
  validates :email, uniqueness: {  case_sensitive: false }
  validates :name, format: { with: /\A[a-zA-Z. ]*\z/, message: 'please use only English alphabets' },
                   length: { in: 4..60 }

  has_many :medical_records, dependent: :destroy
  has_many :share_records, dependent: :destroy

  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable
end
