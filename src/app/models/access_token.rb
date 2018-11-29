# frozen_string_literal: true

class AccessToken < ApplicationRecord
  EXPIRES_IN = 1.hour

  attr_accessor :essence, :refresh_token

  belongs_to :user, required: true

  validates :expires_at, presence: true
  validates :essence_hash, presence: true, uniqueness: true
  validates :refresh_token_hash, presence: true, uniqueness: true

  scope :active, -> { where('expires_at > ?', Time.current) }

  def generate!(user)
    AccessToken.transaction do
      generate_essence
      generate_refresh_token
      generate_expiration_time

      self.user = user
      save!

      self
    end
  end

  private

  def generate_essence
    self.essence = SecureRandom.hex
    self.essence_hash = encode(essence)
  end

  def generate_refresh_token
    self.refresh_token = SecureRandom.hex
    self.refresh_token_hash = encode(refresh_token)
  end

  def generate_expiration_time
    time_current = Time.current
    self.expires_at = time_current + EXPIRES_IN
  end

  def active?
    expires_at > Time.current
  end

  def refresh
    self.expires_at = Time.current
  end

  def encode(string)
    Digest::SHA2.hexdigest(string)
  end
end
