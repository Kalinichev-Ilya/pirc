# frozen_string_literal: true

module API
  module V1
    module Auth
      class Create < Grape::API
        helpers do
          def authenticate
            params.tap do |params|
              params[:device][:ip] = device_params[:ip]
            end

            Operations::Auth::Validate.call(params)
          end

          def create_access_token!(user)
            AccessToken.generate!(user, device_params)
          end

          def device_params
            { ip:          request.ip,
              fingerprint: params[:devise][:fingerprint] }
          end
        end

        version :v1 do
          # POST /api/v1/auth
          desc 'Authenticate a user',
            named:   'authenticate',
            success: { code: 201, model: API::V1::Entities::Auth }
          params do
            requires :username, type: String
            requires :password, type: String
            requires :device, type: Hash do
              requires :fingerprint, type: String
            end
          end
          post do
            result = authenticate
            error! authenticator_error(result.error), 401 if result.failure?
            present create_access_token!(result.user), with: API::V1::Entities::Auth
          end
        end
      end
    end
  end
end
