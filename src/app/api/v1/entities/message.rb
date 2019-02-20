# frozen_string_literal: true

module API
  module V1
    module Entities
      class Channel < Base
        expose :id
        expose :user_id
        expose :text
        expose :created_at
      end
    end
  end
end
