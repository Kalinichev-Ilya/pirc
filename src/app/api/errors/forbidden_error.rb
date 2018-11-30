# frozen_string_literal: true

module API
  module Errors
    class ForbiddenError < BaseError
      def code
        :forbidden
      end

      module V1
        def to_h
          super.merge(errors: errors).compact
        end
      end
    end
  end
end
