# frozen_string_literal: true

module API
  module V1
    module Helpers
      module Base
        extend ActiveSupport::Concern

        included do
          helpers do
            def authenticate!
              error!(Errors::UnauthorizedError.new, 401) unless current_user
            end

            def current_user
              @current_user ||= current_access_token && fetch_user(current_access_token)
            end

            def authenticator_error(status) # rubocop:disable MethodLength CyclomaticComplexity
              type = case status.to_sym
                     when :device_verification_needed
                       API::Errors::DeviceNotVerifiedError
                     when :invalid_email_or_password
                       API::Errors::InvalidEmailOrPasswordError
                     when :unauthorized
                       API::Errors::UnauthorizedError
                     when :channel_already_exist
                       API::Errors::ChannelAlreadyExistError
                     when :member_exist
                       API::Errors::MemberExistError
                     when :user_not_a_member
                       API::Errors::UserNotAMemberError
                     else
                       API::Errors::UnexpectedError
                     end
              type.new(status)
            end

            def current_access_token
              @current_access_token ||= AccessToken.find_through_encode(headers['X-Auth-Token'])
            end

            private

            def fetch_user(access_token)
              access_token.user
            end
          end
        end
      end
    end
  end
end
