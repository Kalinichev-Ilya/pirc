module V1
  module Entities
    class User < Base
      expose :id, format_with: :string, documentation: { type: 'string' }
      expose :username, documentation: { type: 'string' }
      expose :password_digest, documentation: { type: 'string' }
    end
  end
end
