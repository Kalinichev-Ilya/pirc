# frozen_string_literal: true

class AccessToken < ApplicationRecord
  EXPIRES_IN = 1.hour

  validates :expires_at, presence: true
  validates :essence, presence: true, uniqueness: true

  scope :active, -> { where('expires_at > ?', Time.current - EXPIRES_IN) }

  def self.generate!(user, device_params)
    AccessToken.transaction do
      time_current = Time.current
      ip = device_params[:ip]

      essence_hash = encrypt_essence(user, ip, time_current.to_i)
      fingerprint_hash = encode(device_params[:fingerprint].to_s)
      expires_at = time_current + EXPIRES_IN

      AccessToken.create!(essence: essence_hash, fingerprint_hash: fingerprint_hash, ip: ip, expires_at: expires_at)
    end
  end

  def active?
    expires_at > Time.current
  end

  def self.encode(string)
    Digest::SHA2.hexdigest(string)
  end

  def self.encrypt_essence(user, ip, time_stamp)
    essence_string = "#{user.username}:#{ip}:#{time_stamp}"
    encode(essence_string)
  end
end