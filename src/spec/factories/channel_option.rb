# frozen_string_literal: true

FactoryBot.define do
  factory :channel_option do
    association :user
    association :channel

    user_id { user.id }
    channel_id { channel.id }
    is_favorite { [true, false].sample }
  end
end
