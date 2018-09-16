# frozen_string_literal: true

module API
  module V1
    module Users
      class Root < Grape::API
        include API::V1::Entities

        namespace :users do
          mount Users::Create
        end
      end
    end
  end
end
