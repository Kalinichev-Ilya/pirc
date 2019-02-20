# frozen_string_literal: true

module API
  module V1
    module Users
      module Channels
        class Root < Grape::API
          include API::V1::Entities

          namespace :channels do
            mount Channels::Index
          end
        end
      end
    end
  end
end
