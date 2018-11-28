# frozen_string_literal: true

module API
  module Errors
    class InvalidEmailOrPasswordError < BaseError
      def code
        :invalid_email_or_password
      end

      module V1
        def errors
          [
            attribute: 'email_or_password',
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
