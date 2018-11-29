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
      end

      def call
        validate!
      end

      private

      def validate!
        return failure(:invalid_email_or_password) unless valid_password?

        success
      end

      def valid_password?
        user.authenticate(request_password)
      end

      def encode(string)
        Digest::SHA2.hexdigest(string)
      end

      def success
        Result.new(user, nil)
      end

      def failure(error)
        Result.new(nil, error)
      end

      Result = Struct.new(:user, :error) do
        def failure?
          error.present?
        end
      end
    end
  end
end
