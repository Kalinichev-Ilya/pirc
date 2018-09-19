# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:owner] do
    username { Faker::Internet.user_name(4..15) }
    password { Faker::Internet.password(8, 18, true, true) }

    trait :invalid do
      username { 'min' }
    end

    trait :weak_pass do
      password { 'qwerty123' }
    end
  end
end
