# frozen_string_literal: true

FactoryBot.define do
  factory :channel do
    owner
    name { Faker::RickAndMorty.name }
  end
end
