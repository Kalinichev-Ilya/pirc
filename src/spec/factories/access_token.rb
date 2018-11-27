# frozen_string_literal: true

FactoryBot.define do
  factory :access_token do
    essence { Faker::Crypto.sha256 }
    fingerprint { rand(10000..999999) }
    ip { Faker::Internet.ip_v4_address }
    expires_at { Time.current + 1.hour }
  end

  trait :expired do
    expires_at { Time.current - 0.01.hours }
  end
end
