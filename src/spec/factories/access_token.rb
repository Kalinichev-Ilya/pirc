# frozen_string_literal: true

FactoryBot.define do
  factory :access_token do
    user

    essence_hash { Digest::SHA2.hexdigest('valid_essence') }
    refresh_token_hash { Digest::SHA2.hexdigest('valid_refresh_token') }
    expires_at { Time.current + 1.hour }
  end

  trait :expired do
    expires_at { Time.current - 0.01.hours }
  end
end
