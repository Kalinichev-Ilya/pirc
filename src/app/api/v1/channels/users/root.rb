# frozen_string_literal: true

module API
  module V1
    module Channels
      module Users
        class Root < Grape::API
          namespace :users do
            mount Channels::Users::Index
          end
        end
      end
    end
  end
end
