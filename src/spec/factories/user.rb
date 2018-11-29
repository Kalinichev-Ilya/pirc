# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:owner] do
    username { Faker::Internet.user_name(4..15) }
    password { 'wHaT3vEr!' + Faker::Internet.password(8, 55, true, true) }

    trait :dummy do
      username { 'wha' }
      password { 'whatever' }
    end
  end
end
