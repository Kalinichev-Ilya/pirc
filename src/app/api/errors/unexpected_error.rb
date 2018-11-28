module API
  module Errors
    class UnexpectedError < BaseError
      def code
        :server_fault
      end

      module V1
        def to_h
          super.merge(message: message).compact
        end
      end
    end
  end
end
