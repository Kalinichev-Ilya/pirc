# frozen_string_literal: true

module API
  module Entities
    module User
      class V1 < Base
        expose :id
        expose :username
        expose :password
      end
    end
  end
end
