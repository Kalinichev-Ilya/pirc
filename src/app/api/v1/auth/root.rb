# frozen_string_literal: true

module API
  module V1
    module Auth
      class Root < Grape::API
        include API::V1::Entities

        namespace :auth do
          mount Auth::Create
        end
      end
    end
  end
end
