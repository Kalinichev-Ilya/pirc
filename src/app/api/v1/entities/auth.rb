# frozen_string_literal: true

module API
  module V1
    module Entities
      class Auth < Base
        expose :id
        expose :essence, as: :access_token
        expose :refresh_token
        expose :expires_at, format_with: :unix_timestamp
      end
    end
  end
end
