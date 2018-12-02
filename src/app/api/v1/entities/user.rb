# frozen_string_literal: true

module API
  module V1
    module Entities
      class User < Base
        expose :id
        expose :username
      end
    end
  end
end
