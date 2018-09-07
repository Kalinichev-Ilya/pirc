class Channel < ApplicationRecord
  has_many :users, through: :channel_options
  has_many :messages

  belongs_to :owner, class_name: 'User'
  validates_presence_of :name, :owner_id
  validates :name
end
