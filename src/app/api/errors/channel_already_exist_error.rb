# frozen_string_literal: true

module API
  module Errors
    class DeviceNotVerifiedError < BaseError
      def code
        :channel_already_exist
      end

      module V1
        def errors
          [
            attribute: 'channel_already_exist',
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
