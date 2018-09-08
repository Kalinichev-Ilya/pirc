# frozen_string_literal: true

class User < ApplicationRecord
  has_many :channels, through: :channel_options
  has_many :messages, dependent: :destroy

  has_secure_password

  validates :username, :password_digest, presence: true
  validates :username, length: { maximum: 15 }
end
