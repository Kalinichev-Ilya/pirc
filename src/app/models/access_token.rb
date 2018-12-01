# frozen_string_literal: true

class AccessToken < ApplicationRecord
  attr_accessor :essence, :refresh_token

  belongs_to :user, required: true

  validates :expires_at, presence: true
  validates :essence_hash, presence: true, uniqueness: true
  validates :refresh_token_hash, presence: true, uniqueness: true

  scope :active, -> { where('expires_at > ?', Time.current) }

  def self.find_through_encode(essence)
    essence_hash = Helpers::Encryptor.encode(essence)
    find_by(essence_hash: essence_hash)
  end

  def valid_refresh_token?(refresh_token)
    refresh_token_hash = Helpers::Encryptor.encode(refresh_token)
    self.refresh_token_hash == refresh_token_hash
  end

  def refresh!
    update!(expires_at: 1.hour.since)
    self
  end

  def active?
    expires_at > Time.current
  end
end
