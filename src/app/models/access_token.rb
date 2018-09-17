class AccessToken < ApplicationRecord
  EXPIRES_IN = 1.hour

  attr_accessor :token_hash

  belongs_to :user

  validates :expires_at, presence: true
  validates :token_hash, presence: true, uniqueness: true

  scope :active, -> { where('expires_at > ?', Time.current) }

  def self.generate(user, device_params)
    AccessToken.transaction do
      decoded_token = "#{user.username}:#{user.password}:#{current_time.to_i}"

      token_hash = encode(decoded_token)
      expires_at = current_time + EXPIRES_IN

      fingerprint_hash = encode(device_params[:device_params])

      AccessToken.create!(
          user:       user,
          token_hash: token_hash,
          fingerprint: fingerprint_hash,
          expires_at: expires_at
      )
    end
  end

  def valid?(token)
    return false if active.nil?

    decoded_token = "#{user.auth_time}:#{user.email}:#{token}"
    encoded_token = encode(decoded_token)

    user.token.token_hash == encoded_token
  end

  private

  def self.current_time
    Time.current.beginning_of_minute
  end

  def self.encode(string)
    Digest::SHA2.hexdigest(string)
  end
end
