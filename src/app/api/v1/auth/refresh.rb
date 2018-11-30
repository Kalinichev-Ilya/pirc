# frozen_string_literal: true

module API
  module V1
    module Auth
      class Refresh < Grape::API
        helpers do
          def access_token
            @access_token ||= AccessToken.find_through_encode(headers['X-Auth-Token'])
          end

          def valid_token?
            access_token && access_token&.valid_refresh_token?(declared(params)[:refresh_token])
          end
        end

        namespace :refresh do
          version :v1 do
            # POST /api/v1/auth/refresh
            desc 'Refresh access token',
              named: 'refresh',
              success: { code: 201, model: API::V1::Entities::Auth },
              failure: [{ code: 403, model: API::Errors::ForbiddenError }]
            params do
              requires :refresh_token
            end
            post do
              error! API::Errors::ForbiddenError.new, 403 unless valid_token?
              present access_token.refresh, with: API::V1::Entities::Auth
            end
          end
        end
      end
    end
  end
end
