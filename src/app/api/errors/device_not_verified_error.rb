module API
  module Errors
    class DeviceNotVerifiedError < BaseError
      def code
        :device_verification_needed
      end

      module V1
        def errors
          [
              attribute: 'device',
              code: code,
              message: message
          ]
        end

        def to_h
          super.merge(errors: errors).compact
        end
      end
    end
  end
end
