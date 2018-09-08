# frozen_string_literal: true

class Channel < ApplicationRecord
  has_many :users, through: :channel_options
  has_many :messages, dependent: :destroy

  belongs_to :owner, class_name: 'User'

  validates :name, :owner_id, presence: true
  validates :name, length: { maximum: 30 }
end
