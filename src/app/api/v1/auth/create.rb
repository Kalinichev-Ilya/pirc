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

            Operations::Auth::Validate.new(
              username: params[:username],
              password: params[:password]
            ).call
          end

          def create_access_token!(user)
            AccessToken.new.generate!(user)
          end

          def device_params
            { ip: request.ip,
              fingerprint: params['device']['fingerprint'] }
          end

          # TODO: move to global helpers
          def authenticator_error(status)
            type = case status.to_sym
                   when :device_verification_needed
                     API::Errors::DeviceNotVerifiedError
                   when :invalid_email_or_password
                     API::Errors::InvalidEmailOrPasswordError
                   else
                     API::Errors::UnexpectedError
                   end
            type.new(status)
          end
        end

        version :v1 do
          # POST /api/v1/auth
          desc 'Authenticate a user',
            named: 'authenticate',
            success: { code: 201, model: API::V1::Entities::Auth },
            failure: [
              { code: 401, model: API::Errors::UnexpectedError },
              { code: 401, model: API::Errors::InvalidEmailOrPasswordError }
            ]
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
