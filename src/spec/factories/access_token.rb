# frozen_string_literal: true

FactoryBot.define do
  factory :access_token do
    user
  end

  trait :expired do
    expires_at { Time.current - 0.01.hours }
  end
end
