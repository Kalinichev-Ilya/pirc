# frozen_string_literal: true

module API
  module Entities
    module Auth
      class V1 < Base
        expose :token_hash, as: :access_token
        expose :expires_at, format_with: :unix_timestamp
      end
    end
  end
end
