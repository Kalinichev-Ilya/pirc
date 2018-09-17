# frozen_string_literal: true

module API
  module V1
    module Users
      class Create < Grape::API
        version :v1 do
          # POST /api/v1/users
          desc 'Create new user account',
            named:   'create',
            success: { code: 201, model: API::V1::Entities::User::V1 }
          params do
            requires :username, type: String
            requires :password, type: String
          end
          post do
            attributes = declared(params).to_h

            present ::User.create!(attributes).reload,
              with: API::V1::Entities::User::V1
          end
        end
      end
    end
  end
end
