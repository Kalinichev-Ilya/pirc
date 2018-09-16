# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:owner] do
    username { Faker::Name.user_name(4..15) }
    password_digest { Faker::Internet.password }

    trait :invalid do
      username { 'min' }
    end
  end
end
