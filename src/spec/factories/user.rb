# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:owner] do
    association :access_token

    access_token_id { access_token.id }

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
