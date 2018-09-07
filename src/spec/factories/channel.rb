# frozen_string_literal: true

FactoryBot.define do
  factory :channel do
    association :owner

    name { 'whatever' }
    owner_id { owner.id }
  end
end
