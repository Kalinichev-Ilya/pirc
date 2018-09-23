# frozen_string_literal: true

module Operations
  module Auth
    class Validate
      attr_reader :username, :request_password, :device_params, :user

      def initialize(username:, request_password:, device_params:)
        @user = User.find_by!(username: username)
        @request_password = request_password
        @device_params = device_params
      end

      def call
        validate!
      end

      private

      def validate!
        current_device? && valid_password? ? success : failure(:invalid_email_or_password)
      end

      def current_device?
        already_verified? || failure(:device_verification_needed)
      end

      def already_verified?
        user&.token && user&.token.fingerprint == device_params[:fingerprint]
      end

      def valid_password?
        user.authenticate(request_password)
      end

      def success
        Result.new(user)
      end

      def failure(error)
        Result.new(nil, error)
      end

      Result = Struct.new(:user, :error)
    end
  end
end
