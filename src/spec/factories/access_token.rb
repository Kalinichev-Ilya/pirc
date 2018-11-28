# frozen_string_literal: true

FactoryBot.define do
  factory :access_token do
    essence { Faker::Crypto.sha256 }
    fingerprint_hash { '5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5' } # SHA2(12345)
    ip { '127.0.0.1' } # Faker::Internet.ip_v4_address
    expires_at { Time.current + 1.hour }
  end

  trait :expired do
    expires_at { Time.current - 0.01.hours }
  end
end
