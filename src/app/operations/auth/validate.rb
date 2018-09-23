# frozen_string_literal: true

module Operations
  module Auth
    class Create < Struct.new(:user, :request_password, :device_params)
      def self.call(email:, request_password:, device_params:)
        user = User.find_by!(email: email)

        Operations::Auth::Create.new(user, request_password, device_params).validate
      end

      private

      def validate
        current_device? && valid_password? ? success : failure(:invalid_email_or_password)
      end

      def current_device?
        already_verified? || failure(:device_verification_needed)
      end

      def already_verified?
        user.token && user.token.fingerprint == device_params[:fingerprint]
      end

      def valid_password?
        user.password == encode(request_password)
      end

      def encode(string)
        Digest::SHA2.hexdigest(string)
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
