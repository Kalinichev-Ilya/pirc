# frozen_string_literal: true

class User < ApplicationRecord
  has_many :channels, through: :channel_options
  has_many :messages, dependent: :destroy

  belongs_to :access_token, -> { active }

  has_secure_password

  validates :username, length: { minimum: 4, maximum: 15 }, presence: true
  validate :password_format

  private

  PASSWORD_FORMAT = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,64}$/

  def password_format
    return if PASSWORD_FORMAT.match(password)

    errors.add(:password, "must contain letters, numbers and symbols")
  end
end
