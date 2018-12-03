# frozen_string_literal: true

class User < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :channels, through: :memberships
  has_many :messages, dependent: :destroy
  has_many :access_tokens, dependent: :destroy

  has_secure_password

  validates :username, length: { minimum: 4, maximum: 15 }, presence: true
  validate :password_format

  private

  PASSWORD_FORMAT = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#^])[A-Za-z\d@$!%*?&#^]{8,64}$/

  def password_format
    return if PASSWORD_FORMAT.match(password)

    errors.add(:password, 'must contain letters, numbers and symbols')
  end
end
