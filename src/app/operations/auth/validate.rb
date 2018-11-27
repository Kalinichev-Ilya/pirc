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
        @result = Result.new(nil, [])
      end

      def call
        validate!
      end

      private

      def validate!
        return failure(:device_verification_needed) unless valid_session?
        return failure(:invalid_email_or_password) unless valid_password?

        success
      end

      def valid_password?
        user.authenticate(request_password)
      end

      def valid_session?
        valid_token? && confirmed_device?
      end

      def valid_token?
        return false unless user&.access_token

        user.access_token.active?
      end

      def confirmed_device?
        return false unless user&.access_token

        old_token = user.access_token
        old_token.fingerprint == fingerprint && old_token.ip == ip
      end

      def success
        @result.user = user
        @result
      end

      def failure(error)
        @result[:error] << error
        @result
      end

      def failure?
        @result.error.any?
      end

      Result = Struct.new(:user, :error)
    end
  end
end
