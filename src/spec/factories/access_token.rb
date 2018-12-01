# frozen_string_literal: true

FactoryBot.define do
  factory :access_token do
    user
    essence_hash { Faker::Crypto.sha1 }
    refresh_token_hash { Faker::Crypto.sha1 }
    expires_at { 1.hour.since }
  end

  trait :expired do
    expires_at { Time.current - 0.01.hours }
  end

  trait :not_uniq do
    essence_hash { 'whatever' }
    refresh_token_hash { 'whatever' }
  end
end
