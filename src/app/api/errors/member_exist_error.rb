# frozen_string_literal: true

module API
  module Errors
    class MemberExistError < BaseError
      def code
        :member_exist
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
