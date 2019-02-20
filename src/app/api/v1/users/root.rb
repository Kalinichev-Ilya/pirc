# frozen_string_literal: true

module API
  module V1
    module Users
      class Root < Grape::API
        include API::V1::Entities

        namespace :user do
          mount Users::Create

          route_param :id do
            mount Users::Channels::Root
          end
        end
      end
    end
  end
end
