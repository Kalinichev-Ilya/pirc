class Message < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  validates :message_type, inclusion: { in: %w[plain invite] }
  validates_presence_of :user_id, :channel_id, :message_type
end
