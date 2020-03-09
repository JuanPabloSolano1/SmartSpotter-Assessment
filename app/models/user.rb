# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :bookings, dependent: :destroy
  validates_presence_of :name, :email, :password, :password_digest
  validates :email, uniqueness: true
  validates_format_of :email,:with => /.{0,20}@evil-corp.com/
end
