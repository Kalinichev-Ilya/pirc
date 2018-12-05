# frozen_string_literal: true

module API
  module V1
    module Channels
      module Memberships
        class Root < Grape::API
          namespace :membership do
            mount Channels::Memberships::Create
            mount Channels::Memberships::Update
          end
        end
      end
    end
  end
end
