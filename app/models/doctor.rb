# frozen_string_literal: true

class Doctor < ApplicationRecord
  validates :email, :name, presence: true
  validates :email, uniqueness: {  case_sensitive: false }
  validates :name, format: { with: /\A[a-zA-Z. ]*\z/, message: 'please use only English alphabets' },
                   length: { in: 4..60 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
end
