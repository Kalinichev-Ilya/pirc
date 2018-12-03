# frozen_string_literal: true

FactoryBot.define do
  factory :membership do
    user
    channel

    is_favorite { [true, false].sample }
  end
end
