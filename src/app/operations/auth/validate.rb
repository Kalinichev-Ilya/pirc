# frozen_string_literal: true

module Operations
  module Auth
    class Validate
      attr_reader :username, :request_password, :user, :ip, :fingerprint

      def initialize(username:, password:, device:)
        @user = User.find_by!(username: username)
        @request_password = password
        @ip = device[:ip]
        @fingerprint = device[:fingerprint]
        @result = Result.new(nil, nil)
        @token = user&.access_token
      end

      def call
        validate!
      end

      private

      def validate!
        return failure(:device_verification_needed) unless confirmed_device?
        return failure(:invalid_email_or_password) unless valid_password?

        success
      end

      def valid_password?
        user.authenticate(request_password)
      end

      def confirmed_device?
        return false unless @token # first login
        return false unless valid_token? # expired access token

        @token.fingerprint_hash == encode(fingerprint) && @token.ip == ip
      end

      def valid_token?
        @token.active?
      end

      def encode(string)
        Digest::SHA2.hexdigest(string)
      end

      def success
        @result.user = user
        @result
      end

      def failure(error)
        @result[:error] = error
        @result
      end

      Result = Struct.new(:user, :error) do
        def failure?
          error.present?
        end
      end
    end
  end
end
