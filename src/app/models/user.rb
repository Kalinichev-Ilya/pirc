# frozen_string_literal: true

class User < ApplicationRecord
  has_many :channels, through: :channel_options
  has_many :messages, dependent: :destroy

  has_one :access_token, as: :token

  validates :username, presence: true
  validates :username, length: { minimum: 4, maximum: 15 }

  before_validation :password_format
  before_validation :encode_password, on: :create

  after_create :generate_token

  def auth_time
    created_at.beginning_of_minute.to_i
  end

  private

  def generate_token
    AccessToken.generate(self)
  end

  def encode_password
    self.password = Digest::SHA2.hexdigest(password)
  end

  PASSWORD_FORMAT = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,64}$/

  def password_format
    return if PASSWORD_FORMAT.match(password)

    errors.add(:password, "must contain letters, numbers and symbols")
  end
end
