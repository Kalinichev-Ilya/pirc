class AccessToken < ApplicationRecord
  EXPIRES_IN = 1.hour

  # attr_accessor :token_hash

  has_one :user

  validates :expires_at, presence: true
  validates :essence, presence: true, uniqueness: true

  scope :active, -> { where('expires_at > ?', Time.current) }

  def self.generate!(fingerprint)
    AccessToken.transaction do
      essence_hash     = username + email + ip_address + time_stamp
      fingerprint_hash = encode(fingerprint)
      expires_at       = Time.current + EXPIRES_IN

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

  def self.encode(string)
    Digest::SHA2.hexdigest(string)
  end
end
