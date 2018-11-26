# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:owner] do
    username { Faker::Internet.user_name(4..15) }
    password { Faker::Internet.password(9, 18, true, true) }

    trait :signed do
      association :access_token
    end

    trait :fool do
      username { 'wha' }
      password { 'whatever' }
    end
  end
end
