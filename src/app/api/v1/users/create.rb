# frozen_string_literal: true

module V1
  module Users
    class Create < Grape::API
      namespace :users do
        # POST /api/v1/users
        desc 'Create new user account',
          named:   'create',
          success: { code: 201, model: V1::Entities::User }
        params do
          requires :username, type: String
          requires :password_digest, type: String
        end
        post do
          attributes = declared(params).to_h
          present ::User.create!(attributes).reload,
            with: V1::Entities::User
        end
      end
    end
  end
end
