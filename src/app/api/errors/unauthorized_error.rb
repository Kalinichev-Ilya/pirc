module API
  module Errors
    class UnauthorizedError < BaseError
      def code
        :unauthorized
      end

      module V1
        def errors
          [
              attribute: 'unauthorized',
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
