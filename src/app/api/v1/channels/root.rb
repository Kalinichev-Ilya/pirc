# frozen_string_literal: true

module API
  module V1
    module Channels
      class Root < Grape::API
        include API::V1::Entities

        namespace :channel do
          mount Channels::Create

          route_param :id do
            mount Channels::Memberships::Root
            mount Channels::Messages::Root
          end
        end
      end
    end
  end
end
