# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  validates :user_id, :channel_id, :message_type, presence: true
  validates :message_type, inclusion: { in: %w[plain invite] }
end
