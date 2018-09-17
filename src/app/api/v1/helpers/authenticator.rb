# frozen_string_literal: true

module API
  module V1
    module Helpers
      class Authenticator
        extend ActiveSupport::Concern

        def self.authenticate(email:, password:, devise_params:)
          user = User.find_by!(email: email)

          check_device(user, devise_params) && invalid_password?(user, password) ? success(user) : failure(:invalid_email_or_password)
        end

        private

        def check_device(user, device_params)
          if verification_needed?(user, device_params)
            failure(:device_verification_needed)
          end
        end

        def verification_needed?(user, device_params)
          user.token.nil? || user.token.fingerprint != device_params[:fingerprint]
        end

        def invalid_password?(user, password)
          user.password != encode(password)
        end

        def encode(string)
          Digest::SHA2.hexdigest(string)
        end

        def success(user, device = nil)
          Result.new(user, device)
        end

        def failure(error)
          Result.new(nil, nil, error)
        end

        Result = Struct.new(:user, :device, :error) do
          def success?
            !error
          end

          def failure?
            !!error
          end
        end
      end
    end
  end
end
