class User < ApplicationRecord
  has_many :channels, through: :channel_options
  has_many :messages

  has_secure_password
end
