# frozen_string_literal: true

class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  validates :user_id, :channel_id, presence: true
  validates :is_favorite, inclusion: [true, false]
end
