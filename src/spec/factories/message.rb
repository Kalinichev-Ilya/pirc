# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    association :user
    association :channel

    user_id { user.id }
    channel_id { channel.id }
    message_type { %w[plain invite].sample }
    text { Faker::Lorem.sentence(10) }
  end
end
