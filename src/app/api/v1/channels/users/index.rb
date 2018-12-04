# frozen_string_literal: true

module API
  module V1
    module Channels
      module Users
        class Index < Grape::API
          before do
            authenticate!
          end

          helpers do
            def users
              Channel.find(params[:id]).users
            end
          end

          version :v1 do
            # GET /api/v1/channel/:channel_id/users
            desc 'Get channel users list',
              named: 'users list',
              success: { code: 201, model: API::V1::Entities::User },
              failure: [
                { code: 401, model: API::Errors::UnauthorizedError },
                { code: 401, model: API::Errors::UnexpectedError }
              ]
            get do
              present users, API::V1::Entities::User
            end
          end
        end
      end
    end
  end
end
