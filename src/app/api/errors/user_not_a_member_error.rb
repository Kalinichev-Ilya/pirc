# frozen_string_literal: true

module API
  module Errors
    class UserNotAMemberError < BaseError
      def code
        :user_not_a_member
      end

      module V1
        def errors
          [
            attribute: 'user_id',
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
