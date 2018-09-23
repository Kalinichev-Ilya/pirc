class AccessToken < ApplicationRecord
  EXPIRES_IN = 1.hour

  # attr_accessor :token_hash

  has_one :user

  validates :expires_at, presence: true
  validates :essence, presence: true, uniqueness: true

  scope :active, -> { where('expires_at > ?', Time.current) }

  def self.generate!(user, device_params)
    AccessToken.transaction do
      time_current = Time.current

      essence_hash     = encrypt_essence(user, device_params[:ip], time_current)

      fingerprint_hash = encode(device_params[:fingerprint].to_s)
      expires_at       = time_current + EXPIRES_IN

      AccessToken.create!(
          essence:     essence_hash,
          fingerprint: fingerprint_hash,
          expires_at:  expires_at
      )
    end
  end

  private

  def active?
    expires_at > Time.current
  end

  def self.encrypt_essence(user, ip, time_stamp)
    essence_string = "#{user.username}:#{ip}:#{time_stamp.to_i}"
    encode(essence_string)
  end

  def self.encode(string)
    Digest::SHA2.hexdigest(string)
  end
end
