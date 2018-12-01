# frozen_string_literal: true

module API
  module V1
    module Channels
      class Root < Grape::API
        include API::V1::Entities

        namespace :channel do
          mount Channels::Create
        end
      end
    end
  end
end
