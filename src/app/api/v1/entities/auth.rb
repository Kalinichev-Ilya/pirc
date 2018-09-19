# frozen_string_literal: true

module API
  module V1
    module Entities
      class Auth < Base
        expose :token_hash, as: :access_token
        expose :expires_at, format_with: :unix_timestamp
      end
    end
  end
end
