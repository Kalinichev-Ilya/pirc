# frozen_string_literal: true

module API
  module V1
    module Entities
      class User < Entities::Base
        expose :id
        expose :username
        expose :password_digest
      end
    end
  end
end
