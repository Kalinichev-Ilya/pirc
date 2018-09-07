class User < ApplicationRecord
  has_many :channels, through: :channel_options
  has_many :messages

  has_secure_password

  validates :username,
            presence: true,
            format:   {
                with: /\A[a-zA-Z\s]+\z/,
                on:   :create
            }
end
