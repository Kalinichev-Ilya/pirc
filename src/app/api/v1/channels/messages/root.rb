# frozen_string_literal: true

module API
  module V1
    module Channels
      module Messages
        class Root < Grape::API
          namespace :message do
            mount Messages::Create
          end
        end
      end
    end
  end
end
